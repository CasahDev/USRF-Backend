import 'package:dart_frog/dart_frog.dart';

import '../../Data/Interface/IPlayedDAO.dart';
import '../Interface/IServicePlayed.dart';

class ServicePlayed implements IServicePlayed {

  ServicePlayed(this.dao);
  IPlayedDAO dao;

  @override
  Future<Response> addPlayerToLineUp(int playerId, String matchId) async {
    return dao.addPlayerToLineUp(playerId, matchId);
  }

  @override
  Future<Response> getLineup(String matchId) async {
    return dao.getLineup(matchId);
  }
}
