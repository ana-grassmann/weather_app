import 'package:flutter/material.dart';

class TranslucentContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const TranslucentContainer({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.borderRadius = 15.0,
    this.padding = const EdgeInsets.all(14.0),
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3), // 30% opacity
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}
