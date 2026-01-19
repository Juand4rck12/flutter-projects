import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  // Controladores para cada campo
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool acceptTerms = false;

  // Validar campos
  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate() && acceptTerms) {
      return true;
    } else {
      return false;
    }
  }

  // Cambiar el estado del checkbox
  void toggleAcceptTerms(bool value) {
    acceptTerms = value;
    notifyListeners();
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    acceptTerms = false;
    notifyListeners();
  }
}
