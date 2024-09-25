import 'DataEnum.dart';
import 'DataFormating/HashClient.dart';
import 'Implementation/UserDAO.dart';
import 'Interface/IUserDAO.dart';

class Data {
  static IUserDAO? _dao;

  static IUserDAO getDAO() {
    _dao ??= Data.createDAO(DataEnum.PRISMA);
    return _dao!;
  }

  static IUserDAO? createDAO(DataEnum dataEnum) {
    switch (dataEnum) {
      case DataEnum.PRISMA:
        _dao = UserDAO(HashClient());
        return _dao;
    }
  }
}
