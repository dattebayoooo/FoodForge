import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';

class GradientBackground extends StatelessWidget {
  

  const GradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.intensepink, AppColor.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}