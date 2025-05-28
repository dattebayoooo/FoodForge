import 'package:flutter/material.dart';
import 'package:food_forge/widgets/custom_bottom_bar.dart';
import 'package:food_forge/widgets/gradient_background.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const SettingsPage({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Градиентный фон
          GradientBackground(),

          // Контент
          Center(
            child: Text(
              'Настройки',
              style: GoogleFonts.montserratAlternates(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // BottomBar
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
