import 'dart:async';
import 'package:flutter/material.dart';
import 'package:volume_detect/volume_detect.dart';

class VolumeCheckScreen extends StatefulWidget {
  const VolumeCheckScreen({super.key});

  @override
  State<VolumeCheckScreen> createState() => _VolumeCheckScreenState();
}

class _VolumeCheckScreenState extends State<VolumeCheckScreen> {
  int _currentVolume = 0;
  int _lastVolume = 0;
  StreamSubscription<int>? _volumeSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToVolume();
  }

  void _subscribeToVolume() {
    _volumeSubscription = VolumeDetect.volumeButtonStream.listen((volume) {
      setState(() {
        _lastVolume = _currentVolume;
        _currentVolume = volume;
      });
    });
  }

  @override
  void dispose() {
    _volumeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUpVolumePress = _currentVolume > _lastVolume;
    bool isDownVolumePress = _currentVolume < _lastVolume;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Volume Check'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.volume_up, size: 50),
              const SizedBox(height: 16),
              Text('Up volume Button: $isUpVolumePress'),
              Text('Down volume Button: $isDownVolumePress'),
              const SizedBox(height: 16),
              const Text(
                'Press the physical volume buttons!',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
