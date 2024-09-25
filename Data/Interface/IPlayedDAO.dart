import 'package:dart_frog/dart_frog.dart';

mixin IPlayedDAO {
  Future<Response> getLineup(String matchId);
  Future<Response> addPlayerToLineUp(int playerId, String matchId);
}