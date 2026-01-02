import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/sale_model.dart';
import 'package:flutter_application_demo/screens/sale/sale_form_screen.dart';
import 'package:flutter_application_demo/services/sale_service.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final SaleService saleService = SaleService();
  late Future<List<SaleModel>> _salesList;

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  void _loadSales() {
    setState(() {
      _salesList = saleService.getSales();
    });
  }

  void _goToForm([SaleModel? saleModel]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SaleFormScreen(sale: saleModel)),
    );
    _loadSales();
  }

  void _confirmDelete(SaleModel sale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar eliminación"),
        content: Text("¿Eliminar venta #${sale.saleId}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await saleService.deleteSale(sale.saleId!);
              _loadSales();
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
      appBar: AppBar(title: const Text("Lista de Ventas"), centerTitle: true),
      body: FutureBuilder<List<SaleModel>>(
        future: _salesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay ventas"));
          }

          final sales = snapshot.data!;

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
                                "Producto ID",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Cantidad",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Fecha",
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
                          rows: sales.map((sale) {
                            return DataRow(
                              cells: [
                                DataCell(Text("${sale.saleId}")),
                                DataCell(Text("${sale.productName}")),
                                DataCell(Text("${sale.quantity}")),
                                DataCell(
                                  Text(
                                    "\$${sale.totalAmount.toStringAsFixed(2)}",
                                  ),
                                ),
                                DataCell(Text(sale.saleDate ?? '')),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Botón Edit
                                      IconButton(
                                        onPressed: () => _goToForm(sale),
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Botón Delete
                                      IconButton(
                                        onPressed: () => _confirmDelete(sale),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
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
