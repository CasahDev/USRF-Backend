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
    HttpMethod.patch => await _patch(context, id),
    _ => Response(body: 'Method not allowed', statusCode: 405),
  };
}

Future<Response> _get(
  RequestContext context,
  String id,
) async {
  return await service.getMatchState(int.parse(id));
}

Future<Response> _patch(
  RequestContext context,
  String id,
) async {
  return service.changeMatchState(
    int.parse(id),
    await context.request.json() as Map<String, dynamic>,
  );
}
