import 'package:dart_frog/dart_frog.dart';

import '../../../Data/Implementation/MatchDAO.dart';
import '../../../Service/Implemantation/ServiceMatch.dart';
import '../../../Service/Interface/IServiceMatch.dart';

IServiceMatch service = ServiceMatch(MatchDAO());

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.get => await _get(context, id),
    HttpMethod.delete => await _delete(context, id),
  _ => Response.json(
        body: {'message': 'Method not allowed'},
        statusCode: 405,
      ),
  };
}

Future<Response> _delete(RequestContext context, String id) {
  return service.deleteLastAction(int.parse(id));
}

Future<Response> _get(RequestContext context, String id,) async {
  return service.getLastAction(int.parse(id));
}