import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/product_model.dart';
import 'package:flutter_application_demo/models/category_model.dart';
import 'package:flutter_application_demo/models/supplier_model.dart';
import 'package:flutter_application_demo/services/product_service.dart';
import 'package:flutter_application_demo/services/category_service.dart';
import 'package:flutter_application_demo/services/supplier_service.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductModel? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => ProductFormScreenState();
}

class ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductService productService = ProductService();
  final CategoryService categoryService = CategoryService();
  final SupplierService supplierService = SupplierService();

  // Controladores para inputs
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;

  // Listas para dropdowns
  List<CategoryModel> _categories = [];
  List<SupplierModel> _suppliers = [];

  // Valores seleccionados
  int? _selectedCategoryId;
  int? _selectedSupplierId;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    _priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    _stockController = TextEditingController(
      text: widget.product?.stockQuantity.toString() ?? '0',
    );
    _selectedCategoryId = widget.product?.categoryId;
    _selectedSupplierId = widget.product?.supplierId;
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    try {
      final categories = await categoryService.getCategories();
      final suppliers = await supplierService.getSuppliers();
      setState(() {
        _categories = categories;
        _suppliers = suppliers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al cargar datos: $e")));
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final description = _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text;
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final stock = int.tryParse(_stockController.text) ?? 0;

      // Crear el objeto
      final newProduct = ProductModel(
        productId: widget.product?.productId, // Mantiene ID si es edición
        name: name,
        description: description,
        price: price,
        stockQuantity: stock,
        categoryId: _selectedCategoryId,
        supplierId: _selectedSupplierId,
      );

      try {
        if (widget.product == null) {
          await productService.createProduct(newProduct);
        } else {
          await productService.updateProduct(newProduct);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error al guardar: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? "Nuevo producto" : "Editar producto",
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: "Nombre"),
                        validator: (value) =>
                            value!.isEmpty ? "Campo requerido" : null,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: "Descripción",
                        ),
                      ),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: "Precio"),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Campo requerido";
                          if (double.tryParse(value) == null) {
                            return "Ingrese un número válido";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _stockController,
                        decoration: const InputDecoration(labelText: "Stock"),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo requerido";
                          if (int.tryParse(value) == null) {
                            return "Ingrese un número entero";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: _selectedCategoryId,
                        decoration: const InputDecoration(
                          labelText: "Categoría",
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text("Sin categoría"),
                          ),
                          ..._categories.map((category) {
                            return DropdownMenuItem<int>(
                              value: category.categoryId,
                              child: Text(category.name),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategoryId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        value: _selectedSupplierId,
                        decoration: const InputDecoration(
                          labelText: "Proveedor",
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text("Sin proveedor"),
                          ),
                          ..._suppliers.map((supplier) {
                            return DropdownMenuItem<int>(
                              value: supplier.supplierId,
                              child: Text(supplier.name),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSupplierId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _save,
                        child: const Text("Guardar"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
