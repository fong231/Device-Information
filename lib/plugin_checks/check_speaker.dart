import 'package:flutter/material.dart';
import 'package:speaker_plugin/speaker_plugin.dart';

class SpeakerCheckScreen extends StatefulWidget {
  const SpeakerCheckScreen({super.key});

  @override
  State<SpeakerCheckScreen> createState() => _SpeakerCheckScreenState();
}

class _SpeakerCheckScreenState extends State<SpeakerCheckScreen> {
  bool _isOn = false;
  String _status = "Unknown";

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
    _listenSpeakerEvents();
  }

  void _checkInitialStatus() async {
    final isOn = await SpeakerPlugin.isSpeakerOn();
    setState(() {
      _isOn = isOn;
      _status = isOn ? "ON" : "OFF";
    });
  }

  void _listenSpeakerEvents() {
    SpeakerPlugin.speakerEvents.listen((event) {
      setState(() {
        _status = event == "SPEAKER_ON" ? "ON" : "OFF";
        _isOn = (event == "SPEAKER_ON");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = _isOn
        ? "assets/images/speaker-on.png"
        : "assets/images/speaker-off.png";

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
          title: const Text('Speaker Check'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Image.asset(imagePath, width: 60, height: 60),
              ),
              Text(
                "Speaker status: $_status",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Text(
                _isOn ? "Speaker is ON" : "Speaker is OFF",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
