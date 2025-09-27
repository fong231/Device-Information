import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:orientation_sensor_plugin/orientation_sensor_plugin.dart';

import 'chart.dart';
import 'sensor_info.dart';

class OrientationScreen extends StatefulWidget {
  const OrientationScreen({super.key});

  @override
  State<OrientationScreen> createState() => _OrientationScreenState();
}

class _OrientationScreenState extends State<OrientationScreen> {
  final List<FlSpot> xValues = List.generate(
    100,
    (index) => FlSpot(index.toDouble(), 0),
  );
  final List<FlSpot> yValues = List.generate(
    100,
    (index) => FlSpot(index.toDouble(), 0),
  );
  final List<FlSpot> zValues = List.generate(
    100,
    (index) => FlSpot(index.toDouble(), 0),
  );
  int timeIndex = 101;

  StreamSubscription<OrientationEvent>? _orientationSub;
  OrientationSensorPlugin orientation = OrientationSensorPlugin();

  String? name, vendor, version, type, resolution, power;
  String? name2, vendor2, version2, type2, resolution2, power2;

  @override
  void initState() {
    super.initState();

    _orientationSub = orientation.getOrientationStream().listen((event) {
      if (!mounted) return;
      setState(() {
        xValues.add(FlSpot(timeIndex.toDouble(), event.azimuth));
        yValues.add(FlSpot(timeIndex.toDouble(), event.pitch));
        zValues.add(FlSpot(timeIndex.toDouble(), event.roll));
        timeIndex++;

        if (xValues.length > 100) {
          xValues.removeAt(0);
          yValues.removeAt(0);
          zValues.removeAt(0);
        }
      });
    });

    _loadSensorInfo();
  }

  @override
  void dispose() {
    _orientationSub?.cancel();
    super.dispose();
  }

  Future<void> _loadSensorInfo() async {
    final info = await orientation.getSensorInfo();
    setState(() {
      name = info['accelerometerName'];
      vendor = info['accelerometerVendor'];
      version = info['accelerometerVersion'].toString();
      type = info['accelerometerType'].toString();
      resolution = info['accelerometerResolution'].toStringAsFixed(2);
      power = info['accelerometerPower'].toStringAsFixed(2);

      name2 = info['magnetometerName'];
      vendor2 = info['magnetometerVendor'];
      version2 = info['magnetometerVersion'].toString();
      type2 = info['magnetometerType'].toString();
      resolution2 = info['magnetometerResolution'].toStringAsFixed(2);
      power2 = info['magnetometerPower'].toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Orientation sensor'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ListTile(
              leading: Image.asset("assets/images/compass.png"),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.circle, color: Colors.red, size: 15),
                      Text(
                        "X: ${xValues.last.y >= 0 ? "+" : ""}${xValues.last.y.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.circle, color: Colors.green, size: 15),
                      Text(
                        "Y: ${yValues.last.y >= 0 ? "+" : ""}${yValues.last.y.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.circle, color: Colors.blue, size: 15),
                      Text(
                        "Z: ${zValues.last.y >= 0 ? "+" : ""}${zValues.last.y.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: Chart(xValues: xValues, yValues: yValues, zValues: zValues),
          ),
          SensorInfoWidget(
            name: name,
            vendor: vendor,
            version: version,
            type: type,
            resolution: resolution,
            power: power,
            name2: name2,
            vendor2: vendor2,
            version2: version2,
            type2: type2,
            resolution2: resolution2,
            power2: power2,
          ),
        ],
      ),
    );
  }
}
