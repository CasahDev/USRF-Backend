import 'package:dart_frog/dart_frog.dart';

mixin IMatchDAO {
  /// Get a match by id
  ///
  /// [id] is the id of the match
  ///
  /// Returns a response with the match and the status code [200] if the match is found
  ///
  /// Returns a response with the message 'Match not found' and the status code [404] if the match is not found
  Future<Response> getMatchById(int id);

  /// Create a match
  ///
  /// [data] is the data of the match
  ///
  /// Returns a response with the message 'Matchs succesfly created' and the status code [200] if the match is created
  ///
  /// Returns a response with the message 'Match could not be created (error: $e)' and the status code [500] if the match could not be created
  Future<Response> createMatch(Map<String, dynamic> data);

  /// Update a match
  ///
  /// [id] is the id of the match
  ///
  /// [data] is the data of the match
  ///
  /// Returns a response with the message 'Match succesfly updated' and the status code [200] if the match is updated
  ///
  /// Returns a response with the message 'Match could not be updated (error: $e)' and the status code [500] if the match could not be updated
  Future<Response> updateMatch(int id, Map<String, dynamic> data);

  /// Delete a match
  ///
  /// [id] is the id of the match
  ///
  /// Returns a response with the message 'Match succesfly deleted' and the status code [200] if the match is deleted
  ///
  /// Returns a response with the message 'Match could not be deleted (error: $e)' and the status code [500] if the match could not be deleted
  Future<Response> deleteMatch(int id);

  /// Get all matchs
  ///
  /// Returns a response with the matchs and the status code [200] if the matchs are found
  ///
  /// Returns a response with the message 'No matchs not found' and the status code [404] if the matchs are not found
  Future<Response> getMatchs();

  /// Get the last match of a team
  ///
  /// [teamId] is the id of the team
  ///
  /// Returns a response with the match and the status code [200] if the match is found
  ///
  /// Returns a response with the message 'Match not found' and the status code [404] if the match is not found
  Future<Response> getLastMatchByTeam(String teamId);

  /// Get the next matchs of the club
  ///
  /// Returns a response with the matchs and the status code [200] if the matchs are found
  ///
  /// Returns a response with the message 'No matchs not found' and the status code [404] if the matchs are not found
  Future<Response> getNextMatchs();

  /// Get the match state
  ///
  /// [id] is the id of the match
  ///
  /// Returns a response with the match state and the status code [200] if the match state is found
  ///
  /// Returns a response with the message 'Match state not found' and the status code [404] if the match state is not found
  Future<Response> getMatchState(int id);

  /// Change the match state
  ///
  /// [id] is the id of the match
  ///
  /// [data] is the new game state of the match
  ///
  /// Returns a response with the message 'Match state succesfly changed' and the status code [200] if the match state is changed
  ///
  /// Returns a response with the message 'Match state could not be changed (error: $e)' and the status code [500] if the match state could not be changed
  ///
  /// Returns a response with the message 'Match state not found' and the status code [404] if the match state is not found
  Future<Response> changeMatchState(int id, Map<String, dynamic> data);

  /// Delete the last action of a match at this time
  ///
  /// [id] is the id of the match
  ///
  /// Returns a response with the last action and the status code [200] if the
  /// last action is found
  ///
  /// Returns a response with the message 'Last action not found' and the status
  ///  code [404] if the last action is not found
  ///
  /// Returns a response with the message 'Match not found' and the status code
  /// [404] if the match is not found
  ///
  /// Returns a response with the message 'Last action could not be deleted
  /// (error: $e)' and the status code [500] if the last action could not be
  /// deleted
  Future<Response> deleteLastAction(int parse);

  /// Get the last action of a match at this time
  ///
  /// [id] is the id of the match
  ///
  /// Returns a response with the last action and the status code [200] if the
  /// last action is found
  ///
  /// Returns a response with the message 'Last action not found' and the status
  /// code [404] if the last action is not found
  ///
  /// Returns a response with the message 'Match not found' and the status code
  /// [404] if the match is not found
  Future<Response> getLastAction(int parse);
}
