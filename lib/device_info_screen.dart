import 'package:flutter/material.dart';
import 'package:device_infor_plugin/device_infor_plugin.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  String deviceName = "Loading...";
  String osVersion = "Loading...";
  String batteryLevel = "Loading...";
  String ramSize = "Loading...";
  String storageSize = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final name = await DeviceInforPlugin.getDeviceName();
      final os = await DeviceInforPlugin.getOSVersion();
      final battery = await DeviceInforPlugin.getBatteryLevel();
      final ram = await DeviceInforPlugin.getTotalRAM();
      final storage = await DeviceInforPlugin.getTotalStorage();

      setState(() {
        deviceName = name ?? "Unknown";
        osVersion = os ?? "Unknown";
        batteryLevel = battery != null ? "$battery%" : "Unknown";
        ramSize = ram != null ? "$ram MB" : "Unknown";
        storageSize = storage != null ? "$storage MB" : "Unknown";
      });
    } catch (e) {
      setState(() {
        deviceName = "Error";
        osVersion = "Error";
        batteryLevel = "Error";
        ramSize = "Error";
        storageSize = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildInfoTile(Icons.phone_android, "Device Name", deviceName),
        _buildInfoTile(Icons.system_update, "OS Version", osVersion),
        _buildInfoTile(Icons.battery_full, "Battery Level", batteryLevel),
        _buildInfoTile(Icons.memory, "RAM", ramSize),
        _buildInfoTile(Icons.sd_storage, "Storage", storageSize),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
