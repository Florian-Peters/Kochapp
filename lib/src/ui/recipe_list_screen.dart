import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/firestore_service.dart';

class RecipeListScreen extends StatelessWidget {
  final RecipeService _recipeService = RecipeService();

  RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Rezepte'),
      ),
      body: StreamBuilder<List<Recipe>>(
        stream: _recipeService.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Keine Rezepte gefunden. Fügen Sie eines hinzu!'));
          }

          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                leading: recipe.imageUrl != null
                    ? Image.network(recipe.imageUrl!)
                    : const Icon(Icons.image),
                title: Text(recipe.name),
                subtitle: Text(recipe.description),
                onTap: () {
                  // Navigieren Sie zum Detailbildschirm
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
