import 'package:flutter/material.dart';
import 'package:store_project/features/auth/auth_repository.dart';

class LoginFormProvider extends ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage = "";

  /// Validar campos
  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validateLogin(String emailOrUser, String password) async {
    try {
      await _authRepository.login(emailOrUser, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceAll("Exception: ", "");
      notifyListeners();
      return false;
    }
  }

  void clearFields() {
    userController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
