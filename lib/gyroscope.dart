import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gyroscope_sensor_plugin/gyroscope_sensor_plugin.dart';

import 'chart.dart';
import 'sensor_info.dart';

class GyroscopeScreen extends StatefulWidget {
  const GyroscopeScreen({super.key});

  @override
  State<GyroscopeScreen> createState() => _GyroscopeScreenState();
}

class _GyroscopeScreenState extends State<GyroscopeScreen> {
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
  StreamSubscription<GyroscopeEvent>? _gyroscopeSub;
  GyroscopeSensorPlugin gyroscope = GyroscopeSensorPlugin();

  String? name, vendor, version, type, resolution, power;

  @override
  void initState() {
    super.initState();

    _gyroscopeSub = gyroscope.getGyroscopeStream().listen((event) {
      if (!mounted) return;
      setState(() {
        xValues.add(FlSpot(timeIndex.toDouble(), event.x));
        yValues.add(FlSpot(timeIndex.toDouble(), event.y));
        zValues.add(FlSpot(timeIndex.toDouble(), event.z));
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
    _gyroscopeSub?.cancel();
    super.dispose();
  }

  Future<void> _loadSensorInfo() async {
    final info = await gyroscope.getSensorInfo();
    setState(() {
      name = info['sensorName'];
      vendor = info['vendor'];
      version = info['version'].toString();
      type = info['type'].toString();
      resolution = info['resolution'].toStringAsFixed(2);
      power = info['power'].toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Gyroscope sensor'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ListTile(
              leading: Image.asset("assets/images/gyroscope.png"),
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
          ),
        ],
      ),
    );
  }
}
