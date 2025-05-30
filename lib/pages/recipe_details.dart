import 'package:flutter/material.dart';
import 'package:food_forge/models/recipe_model.dart';
import 'package:food_forge/assets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: AppColor.intensepink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              recipe.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer, color: AppColor.pink),
                      const SizedBox(width: 8),
                      Text(recipe.cookingTime),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ингредиенты:',
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...recipe.ingredients.map((ing) => Text('• $ing')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}