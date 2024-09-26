import 'package:dart_frog/dart_frog.dart';

import '../../Data/Interface/IMatchHistoryDAO.dart';
import '../Interface/IServiceMatchHistory.dart';

class ServiceMatchHistory implements IServiceMatchHistory {
  ServiceMatchHistory(this.dao);

  final IMatchHistoryDAO dao;

  @override
  Future<Response> addEventToMatchHistory(String id, Map<String, dynamic> event) {
    return dao.addEventToMatchHistory(id, event);
  }


  @override
  Future<Response> getMatchHistory(String id) {
    return dao.getMatchHistory(id);
  }
}