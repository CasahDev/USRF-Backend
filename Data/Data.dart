import '../prisma/generated_dart_client/client.dart';

class Data {
  static PrismaClient? _dao;

  static PrismaClient getDAO() {
    _dao ??= PrismaClient();
    return _dao!;
  }
}
