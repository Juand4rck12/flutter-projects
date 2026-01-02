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
      productId: json["product"]["id"],
      quantity: json["quantity"],
      saleDate: json["saleDate"],
      totalAmount: (json["totalAmount"] as num).toDouble(),
      productName: json["product"]["name"],
    );
  }

  Map<String, dynamic> toJson({bool isUpdate = false}) {
    if (isUpdate) {
      return {
        'sale': saleId,
        'product': {'id': productId},
        'quantity': quantity,
        'totalAmount': totalAmount,
      };
    } else {
      return {
        'product': {'id': productId},
        'quantity': quantity,
        'totalAmount': totalAmount,
      };
    }
  }
}
