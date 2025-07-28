import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeListScreen extends StatelessWidget {
  final List<Recipe> recipes = [
    // Beispiel-Daten
    Recipe(
      id: '1',
      name: 'Spaghetti Carbonara',
      description: 'Ein klassisches italienisches Nudelgericht.',
      ingredients: ['Spaghetti', 'Eier', 'Pecorino', 'Guanciale', 'Pfeffer'],
      steps: ['Kochen Sie die Nudeln.', 'Braten Sie den Speck an.', 'Mischen Sie alles zusammen.'],
      cookingTime: 20,
    ),
    Recipe(
      id: '2',
      name: 'Pfannkuchen',
      description: 'Einfache und leckere Pfannkuchen.',
      ingredients: ['Mehl', 'Eier', 'Milch', 'Zucker', 'Butter'],
      steps: ['Mischen Sie die trockenen Zutaten.', 'Fügen Sie die feuchten Zutaten hinzu.', 'Backen Sie sie in einer Pfanne.'],
      cookingTime: 15,
    ),
  ];

  RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Rezepte'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.name),
            subtitle: Text(recipe.description),
            onTap: () {
              // Navigieren Sie zum Detailbildschirm
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigieren Sie zum Bildschirm zum Hinzufügen von Rezepten
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
