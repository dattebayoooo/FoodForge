import 'package:flutter/material.dart';
import 'package:food_forge/models/recipe_model.dart';
import 'package:food_forge/pages/recipe_details.dart';
import 'package:food_forge/widgets/recipes_grid.dart';
import 'package:food_forge/widgets/gradient_background.dart';
import 'package:food_forge/widgets/custom_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesPage extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final List<Recipe> allRecipes;

  const FavoritesPage({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.allRecipes,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Recipe> get _favorites => 
      widget.allRecipes.where((recipe) => recipe.isFavorite).toList();

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
                        top: Radius.circular(32)),
                    ),
                    child: RecipesGrid(
                      recipes: _favorites,
                      emptyMessage: "Добавьте рецепты в избранное",
                      emptyIcon: Icons.favorite_border,
                      onTap: _navigateToRecipeDetails,
                      onFavoriteTap: _toggleFavorite,
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
}