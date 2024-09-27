import 'package:dart_frog/src/_internal.dart';

import '../../Data/Interface/IMatchDAO.dart';
import '../Interface/IServiceMatch.dart';

class ServiceMatch implements IServiceMatch {

  ServiceMatch(this.dao);
  IMatchDAO dao;

  @override
  Future<Response> createMatch(Map<String, dynamic> data) {
    return dao.createMatch(data);
  }

  @override
  Future<Response> deleteMatch(int id) {
    return dao.deleteMatch(id);
  }

  @override
  Future<Response> getMatchById(int id) {
    return dao.getMatchById(id);
  }

  @override
  Future<Response> getMatchs() {
    return dao.getMatchs();
  }

  @override
  Future<Response> updateMatch(int id, Map<String, dynamic> data) {
    return dao.updateMatch(id, data);
  }

  @override
  Future<Response> getLastMatchByTeam(String team) {
    return dao.getLastMatchByTeam(team);
  }

}
