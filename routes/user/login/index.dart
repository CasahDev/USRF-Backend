import 'package:dart_frog/dart_frog.dart';

import '../../../Data/DataFormating/HashClient.dart';
import '../../../Data/Implementation/UserDAO.dart';
import '../../../Service/Implemantation/ServiceUser.dart';
import '../../../Service/Interface/IServiceUser.dart';

IServiceUser service = ServiceUser(UserDAO(HashClient()));

Future<Response> onRequest(RequestContext context) async {
  return context.request.method == HttpMethod.get
      ? await _login(context)
      : Response(body: 'Method not allowed', statusCode: 405);
}

Future<Response> _login(RequestContext context) async {
  return service.login(
    await context.request.json() as Map<String, dynamic>,
  );
}
