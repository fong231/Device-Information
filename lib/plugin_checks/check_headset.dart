import 'package:flutter/material.dart';
import 'package:headset_plugin/headset_plugin.dart';

class HeadsetCheckScreen extends StatefulWidget {
  const HeadsetCheckScreen({super.key});

  @override
  State<HeadsetCheckScreen> createState() => _HeadsetCheckScreenState();
}

class _HeadsetCheckScreenState extends State<HeadsetCheckScreen> {
  bool _connected = false;
  String _status = "Unknown";
  String _name = "Unknown";

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
    _listenHeadsetEvents();
  }

  void _checkInitialStatus() async {
    final connected = await HeadsetPlugin.isHeadsetConnected();
    setState(() {
      _connected = connected;
      _status = connected ? "CONNECTED" : "DISCONNECTED";
    });
  }

  void _listenHeadsetEvents() {
    HeadsetPlugin.headsetEvents.listen((event) {
      if (event is Map) {
        final status = event["status"];
        final name = event["name"];

        setState(() {
          if (status == "WIRED-CONNECTED") {
            _connected = true;
            _status = "Wired Connected";
          } else if (status == "WIRED-DISCONNECTED") {
            _connected = false;
            _status = "Disconnected";
          } else if (status == "BLUETOOTH-CONNECTED") {
            _connected = true;
            _status = "Bluetooth Connected";
            _name = name;
          } else if (status == "BLUETOOTH-DISCONNECTED") {
            _connected = false;
            _status = "Disconnected";
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String path = "";
    if(_status == "Disconnected"){
      path = "assets/images/no-headphones.png";
    }else{
      path = "assets/images/headphone-available.png";
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Headset Check'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              headPhoneStatus(path),
              Text("Headset status: $_status",
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              Text(_connected ? "Headset plugged in" : "No headset",
                  style: const TextStyle(fontSize: 18)),
              Text(_name != "Unknown" ? _name : ""),
            ],
          ),
        ),
      ),
    );
  }
}

Widget headPhoneStatus(String path){
  return Container(
    margin: EdgeInsets.all(20),
    child: Center(
      child: Image.asset(
        path,
        width: 40, height: 40,),
    ),
  );
}
