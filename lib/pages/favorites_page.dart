import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:food_forge/widgets/custom_bottom_bar.dart';
import 'package:food_forge/widgets/gradient_background.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const FavoritesPage({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<String> _favorites = ['Макарошки', 'Котлеты', 'Курица', 'Боул'];

  void _removeFavorite(int index) {
    setState(() {
      _favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Градиентный фон
          GradientBackground(),

          // Основной контент в белом блоке
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    "Избранное",
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children:
                          _favorites.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.pink.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item,
                                    style: GoogleFonts.montserratAlternates(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.brown,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.favorite, size: 24),
                                    color: AppColor.intensepink,
                                    onPressed: () => _removeFavorite(index),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 100), // Отступ для BottomBar
                ],
              ),
            ),
          ),

          // BottomBar
          Positioned(
            bottom: 40,
            left: 5,
            right: 5,
            child: CustomBottomBar(
              selectedIndex: widget.currentIndex,
              onTabSelected: widget.onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}
