import 'package:flutter/material.dart';

import 'gyroscope.dart';
import 'light.dart';
import 'orientation.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GyroscopeScreen()),
            );
          },
          child: SensorWidget(
            sensorName: "Gyroscope sensor",
            sensorImage: Image.asset("assets/images/gyroscope.png"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrientationScreen(),
              ),
            );
          },
          child: SensorWidget(
            sensorName: "Orientation sensor",
            sensorImage: Image.asset("assets/images/compass.png"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LightScreen()),
            );
          },
          child: SensorWidget(
            sensorName: "Light sensor",
            sensorImage: Image.asset("assets/images/sun.png"),
          ),
        ),
      ],
    );
  }
}

class SensorWidget extends StatelessWidget {
  const SensorWidget({
    super.key,
    required this.sensorName,
    required this.sensorImage,
  });

  final String sensorName;
  final Image sensorImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(leading: sensorImage, title: Text(sensorName)),
    );
  }
}
