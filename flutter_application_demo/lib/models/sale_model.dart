class SaleModel {
  final int? saleId;
  final int productId;
  final int quantity;
  final String? saleDate;
  final double totalAmount;
  // Campo adicional para mostrar nombre del producto en la UI
  final String? productName;

  SaleModel({
    this.saleId,
    required this.productId,
    required this.quantity,
    this.saleDate,
    required this.totalAmount,
    this.productName,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      saleId: json["id"],
      productId: json["product_id"],
      quantity: json["quantity"],
      saleDate: json["sale_date"],
      totalAmount: (json["total_amount"] as num).toDouble(),
      productName: json["product_name"],
    );
  }

  Map<String, dynamic> toJson({bool isUpdate = false}) {
    if (isUpdate) {
      return {
        'sale_id': saleId,
        'product_id': productId,
        'quantity': quantity,
        'total_amount': totalAmount,
      };
    } else {
      return {
        'product_id': productId,
        'quantity': quantity,
        'total_amount': totalAmount,
      };
    }
  }
}
