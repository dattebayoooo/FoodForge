import 'package:flutter/material.dart';
import 'package:food_forge/assets/app_colors.dart';
import 'package:food_forge/pages/recipe_details.dart';
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
  final List<Map<String, dynamic>> _favorites = [
    {
      'name': 'Макароны с сыром',
      'image': 'assets/images/cook.png',
      'time': '25 мин',
      'ingredients': ['Макароны', 'Сыр', 'Молоко', 'Масло'],
      'steps': ['Варите макароны', 'Приготовьте сырный соус', 'Смешайте'],
    },
    // ... другие рецепты
  ];

  void _removeFavorite(int index) {
    setState(() {
      _favorites.removeAt(index);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Рецепт удалён из избранного')));
    });
  }

  void _openRecipeDetails(Map<String, dynamic> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsPage(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          SafeArea(
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
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: _buildContent(),
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildContent() {
    if (_favorites.isEmpty) {
      return _buildEmptyState();
    }
    return _buildRecipesGrid();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 50, color: AppColor.pink),
          const SizedBox(height: 16),
          Text(
            "Добавьте рецепты в избранное",
            style: GoogleFonts.montserratAlternates(
              fontSize: 18,
              color: AppColor.brown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: _favorites.length,
      itemBuilder:
          (context, index) => _buildRecipeCard(_favorites[index], index),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe, int index) {
    return Dismissible(
      key: Key(recipe['name']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) => _removeFavorite(index),
      child: GestureDetector(
        onTap: () => _openRecipeDetails(recipe),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(recipe['image'], fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe['name'],
                          style: GoogleFonts.montserratAlternates(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.brown,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              recipe['time'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: AppColor.intensepink,
                    size: 28,
                  ),
                  onPressed: () => _removeFavorite(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
