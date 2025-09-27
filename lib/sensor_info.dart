import 'package:flutter/material.dart';

class SensorInfoWidget extends StatelessWidget {
  const SensorInfoWidget({
    super.key,
    required this.name,
    required this.vendor,
    required this.version,
    required this.type,
    required this.resolution,
    required this.power,

    this.name2,
    this.vendor2,
    this.version2,
    this.type2,
    this.resolution2,
    this.power2,
  });

  final String? name, vendor, version, type, resolution, power;
  final String? name2, vendor2, version2, type2, resolution2, power2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Table(
        children: [
          TableRow(
            children: [
              Text("Name"),
              Text(name ?? ""),
              if (name2 != null) Text(name2!),
            ],
          ),
          TableRow(
            children: [
              Text("Type"),
              Text(type ?? ""),
              if (type2 != null) Text(type2!),
            ],
          ),
          TableRow(
            children: [
              Text("Vendor"),
              Text(vendor ?? ""),
              if (vendor2 != null) Text(vendor2!),
            ],
          ),
          TableRow(
            children: [
              Text("Version"),
              Text(version ?? ""),
              if (version2 != null) Text(version2!),
            ],
          ),
          TableRow(
            children: [
              Text("Resolution"),
              Text("$resolution °"),
              if (resolution2 != null) Text("$resolution2 °"),
            ],
          ),
          TableRow(
            children: [
              Text("Power"),
              Text("$power mW"),
              if (power2 != null) Text("$power2 mW °"),
            ],
          ),
        ],
      ),
    );
  }
}
