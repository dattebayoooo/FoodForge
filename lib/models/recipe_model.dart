class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final String cookingTime;
  final List<String> ingredients;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cookingTime,
    required this.ingredients,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
      'isFavorite': isFavorite,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      cookingTime: map['cookingTime']?.toString() ?? '0 мин',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}