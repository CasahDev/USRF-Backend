import 'package:dart_frog/dart_frog.dart';

import '../../Data/Interface/ITeamDAO.dart';
import '../Interface/IServiceTeam.dart';

class ServiceTeam implements IServiceTeam {
  ServiceTeam(this.dao);
  ITeamDAO dao;

  @override
  Future<Response> createTeam(Map<String, dynamic> data) {
    return dao.createTeam(data);
  }

  @override
  Future<Response> getTeams() {
    return dao.getTeams();
  }
}