import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:food_forge/home_page/product_section.dart';
import 'package:food_forge/home_page/search_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.intensepink,
                  AppColor.pink,
                ], // цвета градиента
                begin: Alignment.topLeft, // начальная точка
                end: Alignment.bottomRight, // конечная точка
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "Генератор блюд",
                      style: GoogleFonts.montserratAlternates(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
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
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 12),
                            Text(
                              "Сгенерировать",
                              style: GoogleFonts.alumniSans(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/cook.png",
              fit: BoxFit.fitWidth,
              opacity: const AlwaysStoppedAnimation(1),
            ),
          ),
          Positioned(
            bottom: 20, // Отступ от низа (регулируйте по необходимости)
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: AppColor.intensepink,
                borderRadius: BorderRadius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Главная',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Поиск',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Профиль',
                  ),
                ],
                currentIndex: 0,
                selectedItemColor: AppColor.intensepink,
                unselectedItemColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
