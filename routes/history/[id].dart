import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../Data/Implementation/HistoryDAO.dart';
import '../../Service/Implemantation/ServiceHistory.dart';
import '../../Service/Interface/IServiceHistory.dart';

IServiceHistory service = ServiceHistory(HistoryDAO());

Future<Response> onRequest(RequestContext context, String id,) async {
  return switch (context.request.method) {
    HttpMethod.post => await _addHistory(context, id),
    HttpMethod.get => await _getHistory(id),
    HttpMethod.delete => await _deleteHistory(id),
    _ => await Response.json(body:
      {'error': 'Method not allowed'},
      statusCode: HttpStatus.methodNotAllowed,
    ),
  };
}

Future<Response> _deleteHistory(String id) async {
  return service.deleteHistoryById(id);
}

Future<Response> _addHistory(RequestContext context, String id) async {
  return service.addHistory(context.mountedParams);
}

Future<Response> _getHistory(String id) async {
  return service.getHistoryById(id);
}
