import 'package:flutter/material.dart';
import 'package:food_forge/models/recipe_model.dart';
import 'package:food_forge/widgets/recipe_card.dart';
import 'package:food_forge/assets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipesGrid extends StatelessWidget {
  final List<Recipe> recipes;
  final String emptyMessage;
  final IconData emptyIcon;
  final Function(Recipe)? onTap;
  final Function(Recipe)? onFavoriteTap;

  const RecipesGrid({
    super.key,
    required this.recipes,
    this.emptyMessage = 'Рецепты не найдены',
    this.emptyIcon = Icons.search_off,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(emptyIcon, size: 50, color: AppColor.pink),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: GoogleFonts.montserratAlternates(
                fontSize: 16,
                color: AppColor.brown,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) => RecipeCard(
        recipe: recipes[index],
        onTap: () => onTap?.call(recipes[index]),
        onFavoritePressed: () => onFavoriteTap?.call(recipes[index]),
      ),
    );
  }
}