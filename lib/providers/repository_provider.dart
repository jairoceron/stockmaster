import 'package:flutter/material.dart';

import '../data/repositories/postgres_aws_product_repository.dart';
import '../data/repositories/product_repository.dart';
import '../models/user.dart';
// import '../repositories/postgres_aws_product_repository.dart';
// import '../repositories/product_repository.dart';
import '../data/repositories/sqlite_product_service.dart';

class RepositoryProvider with ChangeNotifier {
  AppUser user; // ya no final
  final SQLiteProductService localRepo;
  final PostgresAWSProductRepository remoteRepo;

  RepositoryProvider(this.user, this.localRepo, this.remoteRepo);

  setUser(AppUser newUser) {
    user = newUser;
    notifyListeners();
  }

  ProductRepository get productRepo =>
      user.isGuest ? localRepo : remoteRepo;


}
