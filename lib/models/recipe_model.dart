class Ingredient {
  final String name;
  final String amount; // Например: "200 г", "1 ст.л.", "300 мл"

  Ingredient({required this.name, required this.amount});
}

class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final String cookingTime;
  final List<Ingredient> ingredients;
  final List<String> instructions; // Пошаговая инструкция
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cookingTime,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      cookingTime: map['cookingTime']?.toString() ?? '0 мин',
      ingredients: List<Map<String, dynamic>>.from(map['ingredients'] ?? [])
          .map((i) => Ingredient(
                name: i['name']?.toString() ?? '',
                amount: i['amount']?.toString() ?? '',
              ))
          .toList(),
      instructions: List<String>.from(map['instructions'] ?? []),
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}