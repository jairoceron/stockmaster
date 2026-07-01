import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services.dart';
import '../data/repositories/services_repository.dart';
import '../helpers/uuid_helper.dart';

class ServiceFormViewModelNotifier extends ChangeNotifier {
  final ServicesRepository _repository;
  List<ServiceEntity> _services = [];

  List<ServiceEntity> get services => _services;

  ServiceFormViewModelNotifier(this._repository) {
    _loadServices();
  }

  Future<void> _loadServices() async {
    _services = await _repository.getAllServices();
    notifyListeners();
  }

  Future<ServiceEntity> saveService(Map<String, dynamic> formData) async {
    final service = ServiceEntity(
      id: formData['id']?.toString().isNotEmpty == true
          ? formData['id']
          : generateUuid(),
      idBusiness: formData['idBusiness'],
      idCategory: formData['idCategory'],
      name: formData['name'],
      description: formData['description'],
      image: formData['image'],
      price: formData['price'] != null
          ? double.tryParse(formData['price'].toString())
          : null,
      durationMinutes: formData['durationMinutes'] != null
          ? int.tryParse(formData['durationMinutes'].toString())
          : null,
      professional: formData['professional'],
      taxRate: formData['taxRate'] != null
          ? double.tryParse(formData['taxRate'].toString())
          : null,
      status: "activo",
      syncState: "pending",
      syncStatus: false,
      isDemo: false,
      createdAt: DateTime.now(),
      lastSyncedAt: null,
    );

    await _repository.saveService(service);
    _services.insert(0, service);
    notifyListeners();
    return service; // 👈 devuelve el servicio
  }


  Future<void> deleteService(String id) async {
    await _repository.deleteService(id);
    _services.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
