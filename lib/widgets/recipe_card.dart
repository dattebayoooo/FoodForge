import 'package:flutter/material.dart';
import 'package:food_forge/models/recipe_model.dart';
import 'package:food_forge/assets/app_colors.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16)),
                  child: Image.asset(
                    recipe.imageUrl,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 16),
                          const SizedBox(width: 4),
                          Text(recipe.cookingTime),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (onFavoritePressed != null)
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    recipe.isFavorite 
                        ? Icons.favorite 
                        : Icons.favorite_border,
                    color: AppColor.intensepink,
                  ),
                  onPressed: onFavoritePressed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}