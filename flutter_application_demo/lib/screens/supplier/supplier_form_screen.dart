import 'package:flutter/material.dart';
import 'package:flutter_application_demo/models/supplier_model.dart';
import 'package:flutter_application_demo/services/supplier_service.dart';

class SupplierFormScreen extends StatefulWidget {
  final SupplierModel? supplier;

  const SupplierFormScreen({super.key, this.supplier});

  @override
  State<SupplierFormScreen> createState() => SupplierFormScreenState();
}

class SupplierFormScreenState extends State<SupplierFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final SupplierService supplierService = SupplierService();

  // Controladores para inputs
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.supplier?.name ?? '');
    _emailController = TextEditingController(
      text: widget.supplier?.contactEmail ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.supplier?.phoneNumber ?? '',
    );
    _addressController = TextEditingController(
      text: widget.supplier?.address ?? '',
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text.isEmpty
          ? null
          : _emailController.text;
      final phone = _phoneController.text.isEmpty
          ? null
          : _phoneController.text;
      final address = _addressController.text.isEmpty
          ? null
          : _addressController.text;

      // Crear el objeto
      final newSupplier = SupplierModel(
        supplierId: widget.supplier?.supplierId, // Mantiene ID si es edición
        name: name,
        contactEmail: email,
        phoneNumber: phone,
        address: address,
      );

      try {
        if (widget.supplier == null) {
          await supplierService.createSupplier(newSupplier);
        } else {
          await supplierService.updateSupplier(newSupplier);
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
          widget.supplier == null ? "Nuevo proveedor" : "Editar proveedor",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) => value!.isEmpty ? "Campo requerido" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email de contacto",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Teléfono"),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Dirección"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text("Guardar")),
            ],
          ),
        ),
      ),
    );
  }
}
