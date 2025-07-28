class Recipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final int cookingTime; // in minutes

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
  });
}
