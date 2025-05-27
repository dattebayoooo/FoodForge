import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:food_forge/home_page/custom_bottom_bar.dart';
import 'package:food_forge/home_page/product_section.dart';
import 'package:food_forge/home_page/search_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const HomePage({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPressed = false;
  final List<String> products = [
    'Хлеб', 'Молоко', 'Бананы', 'Майонез', 'Колбаса',
    'Яйцо', 'Курица', 'Сметана', 'Йогурт',
  ];
  final TextEditingController _productController = TextEditingController();

  void _removeProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void _addProduct(String product) {
    if (product.trim().isNotEmpty && !products.contains(product.trim())) {
      setState(() {
        products.add(product.trim());
      });
      _productController.clear();
    }
  }

  @override
  void dispose() {
    _productController.dispose();
    super.dispose();
  }

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
                      const SearchFields(placeholder: 'Укажите время..'),
                      const SizedBox(height: 16),
                      SearchFields(
                        placeholder: 'Добавить продукт...',
                        controller: _productController,
                        onSubmitted: _addProduct,
                      ),
                      const SizedBox(height: 16),
                      ProductSection(
                        products: products,
                        onRemove: _removeProduct,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTapDown: (_) => setState(() => _isPressed = true),
                        onTapUp: (_) => setState(() => _isPressed = false),
                        onTapCancel: () => setState(() => _isPressed = false),
                        onTap: () {
                          debugPrint("Генерация для: ${products.join(", ")}");
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          transform: Matrix4.identity()
                            ..scale(_isPressed ? 0.95 : 1.0),
                          decoration: BoxDecoration(
                            color: AppColor.brown,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            "Сгенерировать",
                            style: GoogleFonts.alumniSans(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Изображение повара
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/cook.png", fit: BoxFit.fitWidth),
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