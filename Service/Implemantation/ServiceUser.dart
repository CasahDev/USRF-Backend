import 'package:dart_frog/dart_frog.dart';

import '../../Data/Interface/IUserDAO.dart';
import '../Interface/IServiceUser.dart';

class ServiceUser with IServiceUser {

  ServiceUser(this.dao);
  IUserDAO dao;

  @override
  Future<Response> createUser(Map<String, dynamic> data) {
    return dao.createUser(data);
  }

  @override
  Future<Response> deleteUser(int id) {
    return dao.deleteUser(id);
  }

  @override
  Future<Response> getUserById(int id) {
    return dao.getUserById(id);
  }

  @override
  Future<Response> getUsers() {
    return dao.getUsers();
  }

  @override
  Future<Response> updateUser(int id, Map<String, dynamic> data) {
    return dao.updateUser(id, data);
  }
}