import 'package:flutter/material.dart';
import 'package:store_project/features/products/models/product_model.dart';
import 'package:store_project/features/products/repositories/product_repository.dart';

class CreateProductProvider extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  /// Validar campos
  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createProduct(
    String title,
    double price,
    String description,
    List<String> images,
    int categoryId,
  ) async {
    try {
      final product = Product(
        id: 0,
        documenId: '',
        title: title,
        price: price,
        description: description,
        images: images,
        categoryId: categoryId,
      );
      await ProductRepository().create(product);
      clearFields();
      return true;
    } catch (e) {
      debugPrint("Error creando producto: $e");
      return false;
    }
  }

  void clearFields() {
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    imageController.clear();
    notifyListeners();
  }
}
