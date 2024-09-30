import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../Data/Implementation/TeamDAO.dart';
import '../../Service/Implemantation/ServiceTeam.dart';
import '../../Service/Interface/IServiceTeam.dart';

IServiceTeam service = ServiceTeam(TeamDAO());

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await _get(context),
    HttpMethod.post => await _post(context),
    _ => Response(body: 'Method not allowed', statusCode: 405),
  };
}

Future<Response> _post(RequestContext context) async {
  return service.createTeam(
    jsonDecode(await context.request.body()) as Map<String, dynamic>,
  );
}

Future<Response> _get(RequestContext context) async {
  return service.getTeams();
}
