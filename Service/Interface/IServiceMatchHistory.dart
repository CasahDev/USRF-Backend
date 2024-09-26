import 'package:dart_frog/dart_frog.dart';

mixin IServiceMatchHistory {
  /// Get the history of a match
  ///
  /// @param matchId The id of the match
  ///
  /// @return The history of the match if it exists
  ///
  /// @throws Response with status code [404] if the history does not exist
  Future<Response> addEventToMatchHistory(String id, Map<String, dynamic> event);

  /// Add an event to the match history
  ///
  /// @param [id] The id of the match
  ///
  /// @param [body] The event to add
  ///
  /// @return Response with status code [200] if the event has been added
  /// @return Response with status code [404] if the match does not exist
  /// @return Response with status code [500] if the event could not be added
  Future<Response> getMatchHistory(String id);
}