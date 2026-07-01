

import 'package:stockmaster/domain/strategies/default_menu_strategy.dart';
import 'package:stockmaster/domain/strategies/drugstore_menu_strategy.dart';
import 'package:stockmaster/domain/strategies/menu_strategy.dart';

class MenuStrategyFactory {
  static MenuStrategy getStrategy(String inventoryType) {
    switch (inventoryType) {
      case 'Droguería / Naturistas':
      case 'Productores / Apiario':
        return DrugstoreMenuStrategy();
      default:
        return DefaultMenuStrategy();
    }
  }
}