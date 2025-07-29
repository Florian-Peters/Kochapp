class Recipe {
  String? id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final int cookingTime; // in minutes
  String? imageUrl;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
    this.imageUrl,
  });

  factory Recipe.fromFirestore(Map<String, dynamic> data, String id) {
    return Recipe(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      steps: List<String>.from(data['steps'] ?? []),
      cookingTime: data['cookingTime'] ?? 0,
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'cookingTime': cookingTime,
      'imageUrl': imageUrl,
    };
  }
}
