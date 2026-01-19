import 'package:flutter/material.dart';
import 'package:forms_example/widgets/email_field.dart';
import 'package:forms_example/widgets/name_field.dart';
import 'package:forms_example/widgets/password_field.dart';
import 'package:forms_example/widgets/phone_field.dart';
import 'package:forms_example/widgets/terms_checkbox.dart';

class FormsScreens extends StatefulWidget {
  const FormsScreens({super.key});

  @override
  State<FormsScreens> createState() => _FormsScreensState();
}

class _FormsScreensState extends State<FormsScreens> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _acceptTerms = false;

  String? _selectedCountry;

  List<String> countries = ["Argentina", "Mexico", "Estados Unidos", "Perú"];

  String? validateFields(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20.0),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Seleccione su pais",
                ),
                initialValue: _selectedCountry,
                items: countries.map((String country) {
                  return DropdownMenuItem(value: country, child: Text(country));
                }).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    _selectedCountry = newvalue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor seleccione un pais";
                  }
                  return null;
                },
              ),

              // ----- Campo de nombre -----
              NameField(nameController: _nameController),
              const SizedBox(height: 20.0),
              // ----- Campo de email -----
              EmailField(emailController: _emailController),
              const SizedBox(height: 20.0),
              // ----- Campo de contraseña -----
              PasswordField(passwordController: _passwordController),
              const SizedBox(height: 20.0),
              // ----- Campo de teléfono -----
              PhoneField(phoneController: _phoneController),
              const SizedBox(height: 20.0),
              // ----- Checkbox de condiciones -----
              TermsCheckbox(
                value: _acceptTerms,
                onChanged: (bool? value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
              ),
              if (!_acceptTerms)
                const Text(
                  "Debes aceptar los terminos y condiciones",
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) return;
                  if (!_acceptTerms) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Formulario valido")),
                  );
                },
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
