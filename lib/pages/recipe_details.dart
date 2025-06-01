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
        title: Text(recipe.name, style: GoogleFonts.montserratAlternates(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        backgroundColor: AppColor.mediumpink,
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
                  // Время приготовления
                  Row(
                    children: [
                      const Icon(Icons.timer, color: AppColor.pink),
                      const SizedBox(width: 8),
                      Text(
                        'Время приготовления: ${recipe.cookingTime}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Ингредиенты
                  Text(
                    'Ингредиенты:',
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map(
                    (ing) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 16)),
                          Text(
                            '${ing.name} - ${ing.amount}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Инструкция
                  Text(
                    'Способ приготовления:',
                    style: GoogleFonts.montserratAlternates(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.instructions.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.key + 1}. ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}