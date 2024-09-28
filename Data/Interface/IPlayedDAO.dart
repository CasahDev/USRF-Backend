import 'package:dart_frog/dart_frog.dart';

mixin IPlayedDAO {
  /// Get all the players that played in a match
  ///
  /// [matchId] is the id of the match
  ///
  /// Returns a response with the players and the status code [200] if the players are found
  ///
  /// Returns a response with the message 'No players found' and the status code [404] if the players are not found
  ///
  /// Returns a response with the message 'Error: $e' and the status code [500] if an error occurs
  Future<Response> getLineup(String matchId);

  /// Add a player to the lineup
  ///
  /// [playerId] is the id of the player
  ///
  /// [matchId] is the id of the match
  ///
  /// Returns a response with the message 'Player added to the lineup' and the status code [200] if the player is added to the lineup
  ///
  /// Returns a response with the message 'Player could not be added to the lineup' and the status code [500] if the player could not be added to the lineup
  ///
  /// Returns a response with the message 'Player already in the lineup' and the status code [400] if the player is already in the lineup
  ///
  /// Returns a response with the message 'Match not found' and the status code [404] if the match is not found
  ///
  /// Returns a response with the message 'Player not found' and the status code [404] if the player is not found
  Future<Response> addPlayerToLineUp(int playerId, String matchId);
}