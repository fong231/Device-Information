import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:light_sensor_plugin/light_sensor_plugin.dart';

import 'chart.dart';
import 'sensor_info.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({super.key});

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  final List<FlSpot> xValues = List.generate(
    100,
    (index) => FlSpot(index.toDouble(), 0),
  );
  int timeIndex = 101;

  LightSensorPlugin light = LightSensorPlugin();
  StreamSubscription<LightEvent>? _lightSub;

  String? name, vendor, version, type, resolution, power;

  @override
  void initState() {
    super.initState();

    _lightSub = light.getLightStream().listen((event) {
      if (!mounted) return;
      setState(() {
        xValues.add(FlSpot(timeIndex.toDouble(), event.lux));
        timeIndex++;

        if (xValues.length > 100) {
          xValues.removeAt(0);
        }
      });
    });

    _loadSensorInfo();
  }

  @override
  void dispose() {
    _lightSub?.cancel();
    super.dispose();
  }

  Future<void> _loadSensorInfo() async {
    final info = await light.getSensorInfo();
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Light sensor'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: ListTile(
              leading: Image.asset("assets/images/sun.png"),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.circle, color: Colors.red, size: 15),
                      Text(
                        "X: ${xValues.last.y >= 0 ? "+" : ""}${xValues.last.y.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 300, child: Chart(xValues: xValues)),
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
