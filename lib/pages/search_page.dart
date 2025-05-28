import 'package:flutter/material.dart';
import 'package:food_forge/assets/app_colors.dart';
import 'package:food_forge/widgets/custom_bottom_bar.dart';
import 'package:food_forge/widgets/gradient_background.dart';
import 'package:food_forge/widgets/product_section.dart';
import 'package:food_forge/widgets/search_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const SearchPage({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _selectedProducts = [
    'Хлеб',
    'Омлет',
    'Пюре',
    'Майонез',
    'Колбаса',
    'Яйцо',
  ];
  final TextEditingController _searchController = TextEditingController();
  bool _isPressed = false;

  final List<Map<String, dynamic>> _recentSearches = [
    {'name': 'Сосиски в тесте', 'icon': '💬'},
    {'name': 'Суп куриный', 'icon': '💮'},
    {'name': 'Омлет с яйцами страуса', 'icon': '💯'},
  ];

  void _removeProduct(int index) {
    setState(() {
      _selectedProducts.removeAt(index);
    });
  }

  void _removeRecentSearch(int index) {
    setState(() {
      _recentSearches.removeAt(index);
    });
  }

  void _addProduct(String product) {
    if (product.trim().isNotEmpty &&
        !_selectedProducts.contains(product.trim())) {
      setState(() {
        _selectedProducts.add(product.trim());
        // Добавляем в историю поиска
        _recentSearches.insert(0, {
          'name': product.trim(),
          'icon': '🕒', // Иконка времени для новых записей
        });
      });
      _searchController.clear();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    "Поиск Рецептов",
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
                      children: [
                        // Поле поиска
                        SearchFields(
                          placeholder: "Укажите продукты или название блюда",
                          controller: _searchController,
                          onSubmitted: _addProduct,
                        ),
                        const SizedBox(height: 20),

                        // Выбранные продукты
                        const SizedBox(height: 10),
                        ProductSection(
                          products: _selectedProducts,
                          onRemove: _removeProduct,
                        ),
                        const SizedBox(height: 20),

                        // Кнопка "Найти"
                        GestureDetector(
                          onTapDown: (_) => setState(() => _isPressed = true),
                          onTapUp: (_) => setState(() => _isPressed = false),
                          onTapCancel: () => setState(() => _isPressed = false),
                          onTap: () {
                            debugPrint(
                              "Поиск рецептов для: ${_selectedProducts.join(", ")}",
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            transform:
                                Matrix4.identity()
                                  ..scale(_isPressed ? 0.95 : 1.0),
                            decoration: BoxDecoration(
                              color: AppColor.brown,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: Text(
                              "Найти",
                              style: GoogleFonts.alumniSans(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Недавние поиски
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Недавние запросы:",
                            style: GoogleFonts.montserratAlternates(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.brown,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ..._recentSearches.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColor.pink.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              title: Text(
                                item['name'],
                                style: GoogleFonts.montserratAlternates(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.brown,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item['icon'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 20),
                                    color: AppColor.brown,
                                    onPressed: () => _removeRecentSearch(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
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
