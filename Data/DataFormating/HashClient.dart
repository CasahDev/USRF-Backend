import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'Interface/IHashClient.dart';

class HashClient with IHashClient {
  @override
  String generateSalt() {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = Random();

    return String.fromCharCodes(Iterable.generate(
      5, (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),),);
  }

  @override
  String hash(String data) {

    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

}