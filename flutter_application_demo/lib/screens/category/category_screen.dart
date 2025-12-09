import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/category_model.dart';
import 'package:flutter_application_demo/screens/category/category_form_screen.dart';
import 'package:flutter_application_demo/services/category_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryService categoryService = CategoryService();
  late Future<List<CategoryModel>> _categoriesList;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    setState(() {
      _categoriesList = categoryService.getCategories();
    });
  }

  void _goToForm([CategoryModel? categoryModel]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryFormScreen(category: categoryModel),
      ),
    );
    _loadCategories();
  }

  void _confirmDelete(CategoryModel category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar eliminación"),
        content: Text("¿Eliminar '${category.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await categoryService.deleteCategory(category.categoryId!);
              _loadCategories();
            },
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Categorías"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoriesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay categorías"));
          }

          final categories = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  // Botón Add arriba a la derecha
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _goToForm(),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text("Crear"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tabla
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            Colors.grey.shade100,
                          ),
                          columns: const [
                            DataColumn(
                              label: Text(
                                "ID",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Nombre",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Descripción",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Acciones",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: categories.map((category) {
                            return DataRow(
                              cells: [
                                DataCell(Text("${category.categoryId}")),
                                DataCell(Text(category.name)),
                                DataCell(Text(category.description)),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Botón Edit
                                      IconButton(
                                        onPressed: () => _goToForm(category),
                                        icon: const Icon(Icons.edit, color: Colors.blue)
                                      ),
                                      const SizedBox(width: 8),
                                      // Botón Delete
                                      IconButton(
                                        onPressed: () => _confirmDelete(category),
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
