import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/categories/models/category_model.dart';
import 'package:store_project/features/products/providers/create_product_provider.dart';
import 'package:store_project/features/products/repositories/category_repository.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final CategoryRepository _repository = CategoryRepository();
  List<Category> categories = [];
  String? _selectedCategoryId;
  bool _isLoading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (mounted) _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final response = await _repository.getCategories();
      setState(() {
        categories = response;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CreateProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registrar producto",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          spacing: 18.0,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: productProvider.titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "El titulo es obligatorio";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Titulo",
                                  hintText: "Ingrese el titulo del producto",
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: productProvider.priceController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "El precio es obligatorio";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Precio",
                                  hintText: "Ingrese el precio del producto",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),
                        TextFormField(
                          controller: productProvider.descriptionController,
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "La descripción es obligatoria";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Descripción",
                            hintText: "Ingrese la descripción del producto",
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          spacing: 18.0,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: productProvider.imageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "La imagen es obligatoria";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Imagen",
                                  hintText: "Ingrese la URL de la imagen",
                                ),
                              ),
                            ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _selectedCategoryId,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Categoria",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 15.0,
                                  ),
                                ),
                                hint: _isLoading
                                    ? const Text("Cargando...")
                                    : const Text("Seleccione una opción"),
                                items: categories.map((dynamic category) {
                                  return DropdownMenuItem<String>(
                                    value: category.id.toString(),
                                    child: Text("${category.name}"),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCategoryId = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Por favor seleccione una categoria";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  children: [
                    Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Vista Previa",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            AspectRatio(
                              aspectRatio: 1, // Square image
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: ValueListenableBuilder<TextEditingValue>(
                                  valueListenable:
                                      productProvider.imageController,
                                  builder: (context, value, child) {
                                    if (value.text.isEmpty) {
                                      return Image.asset(
                                        'assets/not-available.jpg',
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return Image.network(
                                      value.text,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/not-available.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          // Mostrar indicador de carga
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Guardando producto...'),
                              duration: Duration(seconds: 1),
                            ),
                          );

                          final result = await productProvider.createProduct(
                            productProvider.titleController.text,
                            double.parse(productProvider.priceController.text),
                            productProvider.descriptionController.text,
                            [productProvider.imageController.text],
                            int.parse(_selectedCategoryId!),
                          );

                          if (result && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Producto creado exitosamente'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            setState(() {
                              _selectedCategoryId = null;
                            });
                          } else if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Error al crear el producto. Revisa la consola.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        label: const Text(
                          "Guardar producto",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        icon: const Icon(Icons.save, size: 30.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
