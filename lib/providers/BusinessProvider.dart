import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/businesss.dart';

import '../data/database/local/app_database.dart';

class BusinessProvider extends ChangeNotifier {
  BusinessEntity? _business;

  BusinessEntity? get business => _business;

  void setBusiness(BusinessEntity business) {
    _business = business;
    notifyListeners();
  }
}
