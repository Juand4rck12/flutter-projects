import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorMessage = "";

  /// Validar campos
  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void validateCredentials() {
    String user = userController.text;
    String password = passwordController.text;
    if (user != "Admin2026" || password != "Contraseña1234") {
      errorMessage = "Usuario y/o contraseña incorrectos";
      clearFields();
    } else {
      errorMessage = null;
    }
    notifyListeners();
  }

  void clearFields() {
    userController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
