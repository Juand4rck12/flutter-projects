import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_project/features/products/providers/login_form_provider.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<LoginFormProvider>(context);
    final formKey = GlobalKey<FormState>();
    final windowSize = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Acceso administrador",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SizedBox(
            width: windowSize * 0.30,
            child: Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20.0,
                  children: [
                    Icon(Icons.account_circle, size: windowSize * 0.08),
                    const Text(
                      "Ingresar al sistema",
                      style: TextStyle(
                        fontSize: 38.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      controller: formProvider.userController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El usuario es obligatorio";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Usuario",
                        hintText: "Ingrese su nombre de usuario",
                        errorText: formProvider.errorMessage,
                      ),
                    ),
                    TextFormField(
                      controller: formProvider.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "La contraseña es obligatoria";
                        }
                        return null;
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Contraseña",
                        hintText: "Ingrese su contraseña",
                        errorText: formProvider.errorMessage,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!formProvider.validateForm(formKey)) return;
                        formProvider.validateCredentials();
                        if (formProvider.errorMessage != null) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.teal,
                            content: Text(
                              "Acceso concedido!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 14.0,
                        ),
                        child: Text(
                          "Ingresar",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
