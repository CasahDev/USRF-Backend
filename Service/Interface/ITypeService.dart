import 'package:dart_frog/dart_frog.dart';

mixin ITypeService {
  Future<Response> createUser(Map<String, dynamic> data);
  Future<Response> getUsers();
  Future<Response> getUserById(int id);
  Future<Response> updateUser(int id, Map<String, dynamic> data);
  Future<Response> deleteUser(int id);
  Future<Response> getMatchById(int id);
  Future<Response> createMatch(Map<String, dynamic> data);
  Future<Response> addPlayerToLineUp(int playerId, String id);
  Future<Response> getLineup(String id);
  Future<Response> getMatchHistory(String matchId);
  Future<Response> addEventToMatchHistory(String id, Map<String, dynamic> body);
}
