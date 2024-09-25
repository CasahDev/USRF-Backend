import 'package:dart_frog/dart_frog.dart';

import '../../Data/Implementation/MatchDAO.dart';
import '../../Service/Implemantation/ServiceMatch.dart';
import '../../Service/Interface/IServiceMatch.dart';

IServiceMatch service = ServiceMatch(MatchDAO());

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.post => await _createMatch(context),
    HttpMethod.get => await _getMatch(id),
    _ => Response(body: 'Method not allowed', statusCode: 405),
  };
}

Future<Response> _createMatch(RequestContext context) async {
  return service.createMatch(context.request.body as Map<String, dynamic>);
}

Future<Response> _getMatch(String id) async {
  return service.getMatchById(id as int);
}
