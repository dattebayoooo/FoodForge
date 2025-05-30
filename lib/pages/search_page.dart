import 'package:flutter/material.dart';
import 'package:food_forge/pages/recipe_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_forge/models/recipe_model.dart';
import 'package:food_forge/widgets/recipes_grid.dart';
import 'package:food_forge/widgets/product_section.dart';
import 'package:food_forge/widgets/search_fields.dart';
import 'package:food_forge/widgets/gradient_background.dart';
import 'package:food_forge/widgets/custom_bottom_bar.dart';
import 'package:food_forge/assets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final List<Recipe> allRecipes;

  const SearchPage({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.allRecipes,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _selectedProducts = [];
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchHistory = [];
  bool _showHistory = true;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _searchHistory = prefs.getStringList('searchHistory') ?? []);
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', _searchHistory);
  }

  void _addProduct(String product) {
    if (product.trim().isEmpty) return;
    
    setState(() {
      _selectedProducts.add(product.trim());
      if (!_searchHistory.contains(product.trim())) {
        _searchHistory = [product.trim(), ..._searchHistory.take(4)];
        _saveSearchHistory();
      }
      _searchController.clear();
      _showHistory = false;
    });
  }

  void _removeProduct(int index) {
    setState(() {
      _selectedProducts.removeAt(index);
      _showHistory = _selectedProducts.isEmpty;
    });
  }

  List<Recipe> _getFilteredRecipes() {
    return widget.allRecipes.where((recipe) {
      return _selectedProducts.every((product) => 
        recipe.ingredients.any((ing) => 
          ing.toLowerCase().contains(product.toLowerCase())));
    }).toList();
  }

  void _navigateToRecipeDetails(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsPage(recipe: recipe),
      ),
    );
  }

  void _toggleFavorite(Recipe recipe) {
    setState(() => recipe.isFavorite = !recipe.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = _getFilteredRecipes();

    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Text(
                  "Поиск рецептов",
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
                        top: Radius.circular(32)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: SearchFields(
                            placeholder: "Введите продукт...",
                            controller: _searchController,
                            onSubmitted: _addProduct,
                          ),
                        ),
                        if (_selectedProducts.isNotEmpty)
                          ProductSection(
                            products: _selectedProducts,
                            onRemove: _removeProduct,
                          ),
                        // const SizedBox(height: 16),
                        Expanded(
                          child: _showHistory && _searchHistory.isNotEmpty
                              ? _buildHistorySection()
                              : RecipesGrid(
                                  recipes: filteredRecipes,
                                  emptyMessage: _selectedProducts.isEmpty
                                      ? "Введите продукты для поиска"
                                      : "Нет рецептов с выбранными продуктами",
                                  onTap: _navigateToRecipeDetails,
                                  onFavoriteTap: _toggleFavorite,
                                ),
                        ),
                      ],
                    ),
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

  Widget _buildHistorySection() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _searchHistory.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.history, color: AppColor.pink),
        title: Text(_searchHistory[index]),
        trailing: IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: () {
            setState(() {
              _searchHistory.removeAt(index);
              _saveSearchHistory();
            });
          },
        ),
        onTap: () => _addProduct(_searchHistory[index]),
      ),
    );
  }
}