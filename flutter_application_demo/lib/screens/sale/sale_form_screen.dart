import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/sale_model.dart';
import 'package:flutter_application_demo/models/product_model.dart';
import 'package:flutter_application_demo/services/sale_service.dart';
import 'package:flutter_application_demo/services/product_service.dart';

class SaleFormScreen extends StatefulWidget {
  final SaleModel? sale;

  const SaleFormScreen({super.key, this.sale});

  @override
  State<SaleFormScreen> createState() => SaleFormScreenState();
}

class SaleFormScreenState extends State<SaleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final SaleService saleService = SaleService();
  final ProductService productService = ProductService();

  // Controladores para inputs
  late TextEditingController _quantityController;
  late TextEditingController _totalAmountController;

  // Lista para dropdown de productos
  List<ProductModel> _products = [];

  // Valor seleccionado
  int? _selectedProductId;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.sale?.quantity.toString() ?? '',
    );
    _totalAmountController = TextEditingController(
      text: widget.sale?.totalAmount.toString() ?? '',
    );
    _selectedProductId = widget.sale?.productId;
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    try {
      final products = await productService.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al cargar productos: $e")));
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedProductId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Seleccione un producto")));
        return;
      }

      final quantity = int.tryParse(_quantityController.text) ?? 0;
      final totalAmount = double.tryParse(_totalAmountController.text) ?? 0.0;

      // Crear el objeto
      final newSale = SaleModel(
        saleId: widget.sale?.saleId, // Mantiene ID si es edición
        productId: _selectedProductId!,
        quantity: quantity,
        totalAmount: totalAmount,
      );

      try {
        if (widget.sale == null) {
          await saleService.createSale(newSale);
        } else {
          await saleService.updateSale(newSale);
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
        title: Text(widget.sale == null ? "Nueva venta" : "Editar venta"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<int>(
                      value: _selectedProductId,
                      decoration: const InputDecoration(labelText: "Producto"),
                      items: _products.map((product) {
                        return DropdownMenuItem<int>(
                          value: product.productId,
                          child: Text(
                            "${product.name} - \$${product.price.toStringAsFixed(2)}",
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProductId = value;
                          // Auto-calcular el total si hay cantidad
                          _calculateTotal();
                        });
                      },
                      validator: (value) =>
                          value == null ? "Seleccione un producto" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(labelText: "Cantidad"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo requerido";
                        if (int.tryParse(value) == null) {
                          return "Ingrese un número entero";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _calculateTotal();
                      },
                    ),
                    TextFormField(
                      controller: _totalAmountController,
                      decoration: const InputDecoration(
                        labelText: "Monto total",
                      ),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _save,
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _calculateTotal() {
    if (_selectedProductId != null) {
      final product = _products.firstWhere(
        (p) => p.productId == _selectedProductId,
        orElse: () => ProductModel(name: '', price: 0),
      );
      final quantity = int.tryParse(_quantityController.text) ?? 0;
      final total = product.price * quantity;
      _totalAmountController.text = total.toStringAsFixed(2);
    }
  }
}
