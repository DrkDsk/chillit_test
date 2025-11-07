import 'package:chillit_test/src/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child, this.width});

  final Widget? child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(
          color: Colors.black.customOpacity(0.06),
          strokeAlign: 0.4,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.customOpacity(0.06),
            blurRadius: 18,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
