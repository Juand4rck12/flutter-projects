class SupplierModel {
  final int? supplierId;
  final String name;
  final String? contactEmail;
  final String? phoneNumber;
  final String? address;

  SupplierModel({
    this.supplierId,
    required this.name,
    this.contactEmail,
    this.phoneNumber,
    this.address,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      supplierId: json["id"],
      name: json["name"],
      contactEmail: json["contact_email"],
      phoneNumber: json["phone_number"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson({bool isUpdate = false}) {
    if (isUpdate) {
      return {
        'supplier_id': supplierId,
        'name': name,
        'contact_email': contactEmail,
        'phone_number': phoneNumber,
        'address': address,
      };
    } else {
      return {
        'name': name,
        'contact_email': contactEmail,
        'phone_number': phoneNumber,
        'address': address,
      };
    }
  }
}
