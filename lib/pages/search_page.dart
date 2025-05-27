import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:food_forge/home_page/custom_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const SearchPage({
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.intensepink, AppColor.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Контент
          Center(
            child: Text(
              'Поиск рецептов',
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