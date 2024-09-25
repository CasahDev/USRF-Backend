import 'package:dart_frog/dart_frog.dart';

mixin IUserDAO {
  Future<Response> createUser(Map<String, dynamic> datas) ;
  Future<Response> getUsers();
  Future<Response> getUserById(int id);
  Future<Response> updateUser(int id, Map<String, dynamic> data);
  Future<Response> deleteUser(int id);
  Future<Response> login(Map<String, dynamic> data);
  }
