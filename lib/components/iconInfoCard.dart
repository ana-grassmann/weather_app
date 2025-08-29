import 'package:flutter/material.dart';

class IconInfoCard extends StatelessWidget {
  final String info;
  final Icon icon;

  const IconInfoCard({super.key, required this.info, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(children: [icon, Text(info, style: TextStyle(color: Colors.white),)]));
  }
}
