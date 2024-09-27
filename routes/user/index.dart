import 'package:dart_frog/dart_frog.dart';

import '../../Data/DataFormating/HashClient.dart';
import '../../Data/Implementation/UserDAO.dart';
import '../../Service/Implemantation/ServiceUser.dart';
import '../../Service/Interface/IServiceUser.dart';

IServiceUser service = ServiceUser(UserDAO(HashClient()));

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await _getUsers(),
    HttpMethod.post => await _createUser(context),
    _ => Response(body: 'Method not allowed', statusCode: 405)
  };
}

Future<Response> _getUsers() {
  return service.getUsers();
}

Future<Response> _createUser(RequestContext context) async {
  if (context.request.body.toString() == '') {
    return Response(body: 'Request body is required', statusCode: 400);
  }
  return service.createUser(
    await context.request.json() as Map<String, dynamic>,
  );
}
