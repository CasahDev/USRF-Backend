import '../../Data/Interface/IHistoryDAO.dart';
import '../../prisma/generated_dart_client/model.dart';
import 'package:dart_frog/src/_internal.dart';

import '../Interface/IServiceHistory.dart';

class ServiceHistory implements IServiceHistory {

  ServiceHistory(this.dao);

  final IHistoryDAO dao;

  @override
  Future<Response> addEventToMatchHistory(String id, Map<String, dynamic> event) {
    return dao.addEventToMatchHistory(id, event);
  }

  @override
  Future<Response> addHistory(History history) {
    return dao.addHistory(history);
  }

  @override
  Future<Response> deleteAllHistory() {
    return dao.deleteAllHistory();
  }

  @override
  Future<Response> deleteHistory(History history) {
    return dao.deleteHistory(history);
  }

  @override
  Future<Response> getHistory() {
    return dao.getHistory();
  }

  @override
  Future<Response> getMatchHistory(String id) {
    return dao.getMatchHistory(id);
  }
}
