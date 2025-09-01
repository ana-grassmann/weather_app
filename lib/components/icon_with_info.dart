import 'package:flutter/material.dart';

class IconWithInfo extends StatelessWidget {
  final String info;
  final Icon icon;

  const IconWithInfo({super.key, required this.info, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          icon,
          Text(
            info,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
