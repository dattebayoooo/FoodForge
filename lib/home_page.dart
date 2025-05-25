import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:food_forge/home_page/custom_bottom_bar.dart';
import 'package:food_forge/home_page/product_section.dart';
import 'package:food_forge/home_page/search_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final products = [
    'Хлеб',
    'Молоко',
    'Бананы',
    'Майонез',
    'Колбаса',
    'Яйцо',
    'Курица',
    'Сметана',
    'Йогурт',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Градиентный фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.intensepink, AppColor.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Основной контент
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Text(
                  "Генератор блюд",
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      SearchFields(placeholder: 'Укажите время..'),
                      const SizedBox(height: 16),
                      SearchFields(placeholder: 'Укажите продукты...'),
                      const SizedBox(height: 16),
                      ProductSection(products: products),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.brown,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Сгенерировать",
                          style: GoogleFonts.alumniSans(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Изображение повара вни зу
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/cook.png", fit: BoxFit.fitWidth),
          ),

          // Кастомный BottomNavigationBar
          Positioned(
            bottom: 40,
            left: 5,
            right: 5,
            child: CustomBottomBar(
              selectedIndex: _currentIndex,
              onTabSelected: (index) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        ],
      ),
    );
  }
}


