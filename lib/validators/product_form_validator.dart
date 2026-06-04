import 'package:flutter/material.dart';

class ProductFormValidator {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name cannot be empty';
    }
    return null;
  }

  static String? validateStock(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Stock cannot be empty';
    }
    final num? stock = num.tryParse(value);
    if (stock == null) {
      return 'Stock must be a number';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price cannot be empty';
    }
    final num? price = num.tryParse(value);
    if (price == null) {
      return 'Price must be a number';
    }
    return null;
  }
}