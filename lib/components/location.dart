import 'package:flutter/material.dart';

class LocationText extends StatelessWidget {
  final String locationName;
  final Color iconColor;

  const LocationText({
    super.key,
    this.locationName = "Unknown Location",
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: iconColor),
        const SizedBox(width: 8),
        Text(
          locationName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
