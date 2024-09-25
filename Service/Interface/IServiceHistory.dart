import 'package:dart_frog/dart_frog.dart';

import '../../prisma/generated_dart_client/model.dart';

mixin IServiceHistory {
  Future<Response> getHistory();

  Future<Response> addHistory(History history);

  Future<Response> deleteHistory(History history);

  Future<Response> deleteAllHistory();

  Future<Response> getMatchHistory(String id);

  Future<Response> addEventToMatchHistory(
      String id, Map<String, dynamic> event);
}
