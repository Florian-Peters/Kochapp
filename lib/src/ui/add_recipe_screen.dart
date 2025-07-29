import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/recipe.dart';
import '../services/firestore_service.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Rezept hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _image != null
                  ? Image.file(_image!)
                  : const Text('Kein Bild ausgewählt.'),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Bild auswählen'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Rezeptname'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie einen Namen ein';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Beschreibung'),
              ),
              TextFormField(
                controller: _cookingTimeController,
                decoration: const InputDecoration(labelText: 'Kochzeit (in Minuten)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Zutaten (durch Komma getrennt)'),
              ),
              TextFormField(
                controller: _stepsController,
                decoration: const InputDecoration(labelText: 'Schritte (durch Komma getrennt)'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: const Text('Rezept speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl;
      if (_image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('recipe_images')
            .child('${DateTime.now().toIso8601String()}.jpg');
        await storageRef.putFile(_image!);
        imageUrl = await storageRef.getDownloadURL();
      }

      final recipe = Recipe(
        name: _nameController.text,
        description: _descriptionController.text,
        ingredients: _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
        steps: _stepsController.text.split(',').map((e) => e.trim()).toList(),
        cookingTime: int.tryParse(_cookingTimeController.text) ?? 0,
        imageUrl: imageUrl,
      );

      final recipeService = RecipeService();
      recipeService.addRecipe(recipe).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Speichern: $error')),
        );
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _cookingTimeController.dispose();
    super.dispose();
  }
}
