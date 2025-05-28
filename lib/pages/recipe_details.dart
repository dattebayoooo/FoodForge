import 'package:flutter/material.dart';
import 'package:food_forge/assets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        backgroundColor: AppColor.intensepink,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: recipe['name'],
              child: Image.asset(
                recipe['image'],
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.timer, recipe['time']),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Ингредиенты'),
                  _buildBulletList(recipe['ingredients']),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Шаги приготовления'),
                  _buildNumberedList(recipe['steps']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColor.pink),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserratAlternates(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.brown,
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(item, style: const TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildNumberedList(List<String> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          steps
              .asMap()
              .entries
              .map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.key + 1}. ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
              )
              .toList(),
    );
  }
}
