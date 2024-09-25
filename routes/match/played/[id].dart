import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import '../../../Data/Implementation/PlayedDAO.dart';
import '../../../Service/Implemantation/ServicePlayed.dart';
import '../../../Service/Interface/IServicePlayed.dart';

IServicePlayed service = ServicePlayed(PlayedDAO());

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.post => await _addPlayerToLineUp(context, id),
    HttpMethod.get => await _getLineup(id),
    _ =>  Response(body: 'Method not allowed', statusCode: 405),
  };
}

Future<Response> _addPlayerToLineUp(RequestContext context, String id) async {
  final data = jsonEncode(await context.request.body()) as Map<String, dynamic>;
  return service.addPlayerToLineUp(
      int.parse(data['playerId'] as String),
      id);
}

Future<Response> _getLineup(String id) async {
  return service.getLineup(id);
}
