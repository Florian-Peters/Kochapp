import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a stream of all recipes
  Stream<List<Recipe>> getRecipes() {
    return _db.collection('recipes').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Recipe.fromFirestore(doc.data(), doc.id))
        .toList());
  }

  // Add a new recipe
  Future<void> addRecipe(Recipe recipe) {
    return _db.collection('recipes').add(recipe.toFirestore());
  }

  // Update an existing recipe
  Future<void> updateRecipe(Recipe recipe) {
    return _db.collection('recipes').doc(recipe.id).update(recipe.toFirestore());
  }

  // Delete a recipe
  Future<void> deleteRecipe(String recipeId) {
    return _db.collection('recipes').doc(recipeId).delete();
  }
}
