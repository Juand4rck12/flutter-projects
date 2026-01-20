import 'package:flutter/material.dart';
import 'package:store_project/features/products/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  // Lista de productos en el carrito
  final List<Product> _items = [];

  // Getter para obtener los items (solo lectura)
  List<Product> get items => List.unmodifiable(_items);

  // Getter para contar items
  int get itemCount => _items.length;

  /// Método para agregar producto
  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); // Avisa a todos los widgets escuchando
  }

  /// Método para limpiar carrito
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Calcular total
  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.price);
  }
}
