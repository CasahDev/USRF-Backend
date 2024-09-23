import 'package:dart_frog/dart_frog.dart';

import '../../Data/Interface/ITypeDAO.dart';
import '../Interface/ITypeService.dart';

class TypeService with ITypeService {

  TypeService(this.dao);
  ITypeDAO dao;

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

  @override
  Future<Response> createMatch(Map<String, dynamic> data) {
    return dao.createMatch(data);
  }

  @override
  Future<Response> getMatchById(int id) {
    return dao.getMatchById(id);
  }

  @override
  Future<Response> addPlayerToLineUp(int playerId, String id) {
    return dao.addPlayerToLineUp(playerId, id);
  }

  @override
  Future<Response> getLineup(String id) {
    return dao.getLineUpByMatchId(int.parse(id));
  }

  @override
  Future<Response> addEventToMatchHistory(String id, Map<String, dynamic> body) {
    return dao.addEventToMatchHistory(id, body);
  }

  @override
  Future<Response> getMatchHistory(String matchId) {
    return dao.getMatchHistory(matchId);
  }
}