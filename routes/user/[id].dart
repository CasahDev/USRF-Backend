import 'package:dart_frog/dart_frog.dart';

import '../../Data/DataFormating/HashClient.dart';
import '../../Data/Implementation/UserDAO.dart';
import '../../Service/Implemantation/ServiceUser.dart';
import '../../Service/Interface/IServiceUser.dart';

IServiceUser service = ServiceUser(UserDAO(HashClient()));

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.delete => await _deleteUser(context, id),
    HttpMethod.post => await _updateUser(context),
    HttpMethod.get => await _getUserById(id),
    _ => Response(body: 'Method not allowed', statusCode: 405)
  };
}

Future<Response> _deleteUser(RequestContext context, String id) async {
  return service.deleteUser(id as int);
}

Future<Response> _updateUser(RequestContext context) async {
  return service.updateUser(
    context.request.body as int,
    context.mountedParams,
  );
}

Future<Response> _getUserById(String id) {
  return service.getUserById(id as int);
}
