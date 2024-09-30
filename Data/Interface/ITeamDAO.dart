import 'package:dart_frog/dart_frog.dart';

mixin ITeamDAO {
  /// Create a new team
  ///
  /// [body] is a map with the team data
  ///
  /// Returns a response with the result of the operation
  Future<Response> createTeam(Map<String, dynamic> body);

  /// Get all teams
  ///
  /// Returns a response with the result of the operation
  Future<Response> getTeams();
}
