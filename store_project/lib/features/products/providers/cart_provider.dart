import 'package:flutter/material.dart';
import 'package:store_project/features/products/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  // Mapa: productId -> CartItem
  final Map<int, CartItem> _items = {};

  // Getter para obtener los items como lista
  List<CartItem> get items => _items.values.toList();

  // Getter para contar items totales
  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  /// Método para agregar producto (incrementa cantidad si ya existe)
  void addProduct(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  /// Incrementar cantidad
  void incrementQuantity(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  /// Decrementar cantidad
  void decrementQuantity(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId); // remover si llega a 0
    }
    notifyListeners();
  }

  /// Remover producto completamente
  void removeProduct(int productId) {
    if (_items[productId] != null) _items.remove(productId);
    notifyListeners();
  }

  /// Método para limpiar carrito
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Calcular total
  double get totalPrice {
    return _items.values.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
