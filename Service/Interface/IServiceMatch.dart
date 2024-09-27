import 'package:dart_frog/dart_frog.dart';

mixin IServiceMatch {
  Future<Response> getMatchById(int id);
  Future<Response> createMatch(Map<String, dynamic> data);
  Future<Response> updateMatch(int id, Map<String, dynamic> data);
  Future<Response> deleteMatch(int id);
  Future<Response> getMatchs();
  Future<Response> getLastMatchByTeam(String team);
}
