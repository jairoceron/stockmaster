import 'package:flutter/material.dart';

class AppBarConfig {
  final String title;
  final Color color;

  AppBarConfig(this.title, this.color);
}

class AppBarConfigUtils {
  static AppBarConfig getConfig(String transactionType) {
    switch (transactionType) {
      case "input":
        return AppBarConfig("Units Added", Colors.green);
      case "output":
        return AppBarConfig("Units Removed", Colors.red);
      default:
        return AppBarConfig("Inventory", Colors.blueGrey);
    }
  }

  static String getQuantityLabel(String transactionType) {
    if (transactionType == "input") {
      return "Add Quantity";
    } else if (transactionType == "output") {
      return "Remove Quantity";
    }
    return "Quantity";
  }

}