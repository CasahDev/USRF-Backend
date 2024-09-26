import 'package:dart_frog/dart_frog.dart';

import '../../../Data/Implementation/MatchHistoryDAO.dart';
import '../../../Service/Implemantation/ServiceMatchHistory.dart';
import '../../../Service/Interface/IServiceMatchHistory.dart';

IServiceMatchHistory service = ServiceMatchHistory(MatchHistoryDAO());

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch(context.request.method) {
    HttpMethod.post => await _addToMatchHistory(context, id),
    HttpMethod.get => await _getMatchHistory(id),
  _ => Response(body: 'Method not allowed', statusCode: 405),
  };
}

Future<Response> _getMatchHistory(String id) async {
  return service.getMatchHistory(id);
}

Future<Response> _addToMatchHistory(RequestContext context, String id) async {
  return service.addEventToMatchHistory(id, context.request.body as Map<String, dynamic>);
}

