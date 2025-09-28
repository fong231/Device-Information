import 'package:flutter/material.dart';

import '_base/_basePluginWidget.dart';
import 'plugin_checks/check_headset.dart';
import 'plugin_checks/check_volume.dart';

class CheckListScreen extends StatelessWidget {
  const CheckListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HeadsetCheckScreen()),
            );
          },
          child: BaseWidget(
            name: "Headset Check",
            image: Image.asset("assets/images/headphones.png"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VolumeCheckScreen(),
              ),
            );
          },
          child: BaseWidget(
            name: "Volume Check",
            image: Image.asset("assets/images/volume.png"),
          ),
        ),
      ],
    );
  }
}
