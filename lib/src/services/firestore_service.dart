import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a stream of all recipes
  Stream<List<Recipe>> getRecipes() {
    return _db.collection('recipes').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Recipe.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  // Add a new recipe
  Future<void> addRecipe(Recipe recipe) {
    return _db.collection('recipes').add(recipe.toMap());
  }
}

// Erweitern Sie das Recipe-Modell um die Firestore-Konvertierung
extension on Recipe {
  static Recipe fromFirestore(Map<String, dynamic> firestore, String id) {
    return Recipe(
      id: id,
      name: firestore['name'] ?? '',
      description: firestore['description'] ?? '',
      ingredients: List<String>.from(firestore['ingredients'] ?? []),
      steps: List<String>.from(firestore['steps'] ?? []),
      cookingTime: firestore['cookingTime'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'steps': steps,
      'cookingTime': cookingTime,
    };
  }
}
