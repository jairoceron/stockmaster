class Validators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    final regex = RegExp(r'^\+[1-9]\d{1,14}$'); // formato internacional E.164
    if (!regex.hasMatch(value.trim())) {
      return "Enter a valid international number (e.g. +573001234567)";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validatePais(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Country is required";
    }
    return null;
  }

  static String? validateCiudad(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "City is required";
    }
    return null;
  }





  static String? notEmptyValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Campo requerido";
    }
    return null;
  }

  /// Nuevo validador para contraseñas
  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));
    if (!hasUpper || !hasLower || !hasDigit) {
      return "Password must include upper, lower case letters and a number";
    }
    return null;
  }
}