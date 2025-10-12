import 'package:flutter/material.dart';
import 'package:lazastore/core/themes/colors.dart';

class CustomCircularBackground extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double size;
  const CustomCircularBackground({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.lightGray,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: child,
    );
  }
}
