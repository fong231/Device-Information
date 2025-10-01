import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(leading: image, title: Text(name)),
    );
  }
}