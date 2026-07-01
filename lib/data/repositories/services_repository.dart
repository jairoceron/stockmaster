import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/services.dart';

class ServicesRepository {
  final ServicesDao _dao;

  ServicesRepository(this._dao);

  Future<int> saveService(ServiceEntity service) {
    return _dao.insertService(service);
  }

  Future<bool> updateService(ServiceEntity service) {
    return _dao.updateService(service);
  }

  Future<int> deleteService(String id) {
    return _dao.deleteService(id);
  }

  Future<List<ServiceEntity>> getAllServices() {
    return _dao.getAllServices();
  }
}
