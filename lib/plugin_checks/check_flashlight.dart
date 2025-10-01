import 'package:flutter/material.dart';
import 'package:flashlight_plugin/flashlight_plugin.dart';

class FlashlightCheckScreen extends StatefulWidget {
  const FlashlightCheckScreen({super.key});

  @override
  State<FlashlightCheckScreen> createState() => _FlashlightCheckScreenState();
}

class _FlashlightCheckScreenState extends State<FlashlightCheckScreen> {
  bool _isOn = false;
  String _status = "OFF";

  @override
  void initState() {
    super.initState();
    _listenFlashlightEvents();
    _initStatus();
  }

  /// Get initial flashlight status
  Future<void> _initStatus() async {
    bool isOn = await FlashlightPlugin.isOn();
    setState(() {
      _isOn = isOn;
      _status = isOn ? "ON" : "OFF";
    });
  }

  /// Listen flashlight status changes (ON/OFF)
  void _listenFlashlightEvents() {
    FlashlightPlugin.flashlightEvents.listen((event) {
      setState(() {
        _status = event;
        _isOn = (event == "ON");
      });
    });
  }

  /// Toggle flashlight manually
  Future<void> _toggleFlash() async {
    if (_isOn) {
      await FlashlightPlugin.turnOff();
    } else {
      await FlashlightPlugin.turnOn();
    }
  }

  @override
  Widget build(BuildContext context) {
    String path = _isOn
        ? "assets/images/flash-on.png"
        : "assets/images/flash-off.png";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Flashlight Check'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              flashlightStatus(path),
              const SizedBox(height: 16),
              Text(
                "Flashlight status: $_status",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _toggleFlash,
                child: Text(_isOn ? "Turn OFF" : "Turn ON"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget flashlightStatus(String path) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Center(
      child: Image.asset(
        path,
        width: 60,
        height: 60,
      ),
    ),
  );
}
