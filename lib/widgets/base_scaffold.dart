import 'package:flutter/material.dart';
import 'package:food_forge/home_page/custom_bottom_bar.dart';
import 'package:food_forge/widgets/gradient_background.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final bool showCookImage;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTabSelected,
    this.showCookImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(
            child: body,
          ),
          if (showCookImage)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/cook.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          Positioned(
            bottom: 40,
            left: 5,
            right: 5,
            child: CustomBottomBar(
              selectedIndex: currentIndex,
              onTabSelected: onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}