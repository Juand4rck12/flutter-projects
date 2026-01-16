import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/category_model.dart';
import 'package:flutter_application_demo/services/category_service.dart';

class CategoryFormScreen extends StatefulWidget {
  final CategoryModel? category;

  const CategoryFormScreen({super.key, this.category});

  @override
  State<CategoryFormScreen> createState() => CategoryFormScreenState();
}

class CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final CategoryService categoryService = CategoryService();

  // Controladores para inputs
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.category?.description ?? '',
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final description = _descriptionController.text;

      // Crear el objeto
      final newCategory = CategoryModel(
        categoryId: widget.category?.categoryId, // Mantiene ID si es edición
        name: name,
        description: description,
      );

      try {
        if (widget.category == null) {
          await categoryService.createCategory(newCategory);
        } else {
          await categoryService.updateCategory(newCategory);
        }
        if (mounted) Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error al guardar: $e")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null ? "Nueva categoria" : "Editar categoria",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Descripción"),
                // keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text("Guardar")),
            ],
          ),
        ),
      ),
    );
  }
}
