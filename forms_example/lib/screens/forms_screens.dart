import 'package:flutter/material.dart';

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
              // ----- Campo de nombre -----
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  hintText: "Ingrese su nombre",
                ),
                validator: (value) =>
                    validateFields(value, "Por favor escriba su nombre"),
              ),
              const SizedBox(height: 20.0),
              // ----- Campo de email -----
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "email",
                  hintText: "Ingrese su correo electronico",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingrese su correo electronico";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    return "Por favor ingrese un correo valido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              // ----- Campo de contraseña -----
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Ingrese su contraseña",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingrese su contraseña";
                  }
                  if (value.length < 6) {
                    return "Por favor ingrese una contraseña con más de 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              // ----- Campo de teléfono -----
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "teléfono",
                  hintText: "Ingrese su teléfono",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor ingrese su correo electronico";
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Por favor ingrese un teléfono valido";
                  }
                  if (value.length != 10) {
                    return "El número debe tener 10 digitos";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              // ----- Checkbox de condiciones -----
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                  ),
                  const Text("Acepto los terminos y condiciones"),
                ],
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
