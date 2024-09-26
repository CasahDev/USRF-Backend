import 'package:dart_frog/dart_frog.dart';

import '../../prisma/generated_dart_client/model.dart';

mixin IHistoryDAO {
  /// Add a history to the database
  ///
  /// @param [history] The history to add
  ///
  /// @return Response with status code [200] if the history has been added
  ///
  /// @return Response with status code [500] if the history could not be created
  Future<Response> addHistory(Map<String, dynamic> history);

  /// Clear all the history
  ///
  /// @return Response with status code [200] if the history has been cleared
  ///
  /// @return Response with status code [500] if the history could not be cleared
  Future<Response> deleteAllHistory();

  /// Delete a history
  ///
  /// @param [history] The history to delete
  ///
  /// @return Response with status code [200] if the history has been deleted
  Future<Response> deleteHistory(History history);

  /// Get all the history
  ///
  /// @return Response with status code [200[] if the history has been found
  ///
  /// @return Response with status code [404] if the history could not be found
  Future<Response> getHistory();

  /// Delete a history based on his id
  ///
  /// @param [id] The id of the history to delete
  ///
  /// @return Response with status code [200] if the history has been deleted
  ///
  /// @return Response with status code [404] if the history could not be found
  ///
  /// @return Response with status code [500] if the history could not be deleted
  Future<Response> deleteHistoryById(String id);

  /// Get a history based on his id
  ///
  /// @param [id] The id of the history to get
  ///
  /// @return Response with status code [200] if the history has been found
  ///
  /// @return Response with status code [404] if the history could not be found
  ///
  /// @return Response with status code [500] if the history could not be retrieved
  Future<Response> getHistoryById(String id);
}
