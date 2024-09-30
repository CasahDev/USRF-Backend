import 'package:dart_frog/src/_internal.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/model.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Data.dart';
import '../Interface/IHistoryDAO.dart';

class HistoryDAO implements IHistoryDAO {
  HistoryDAO() {
    prismaClient = Data.getDAO();
  }

  late PrismaClient prismaClient;

  @override
  Future<Response> addHistory(Map<String, dynamic> history) async {
    final h = await prismaClient.history.create(
      data: PrismaUnion.$1(
        HistoryCreateInput(
          additionnalInformations: history["additionnalInformations"] as String,
          actionType: history["actionType"] as ActionType,
          author: UserCreateNestedOneWithoutHistoryInput(
            connect: UserWhereUniqueInput(id: (history["author"] as User).id),
          ),
          createdAt: history["createdAt"] as DateTime,
        ),
      ),
    );

    final created = await prismaClient.history.findUnique(
      where: HistoryWhereUniqueInput(id: h.id),
    );

    if (created == null) {
      return Response.json(body: {
        'message': 'The history could not be created',
      }, statusCode: 500);
    }

    return Response.json(
      body: {
        'message': 'History succesfully added !',
      },
    );
  }

  @override
  Future<Response> deleteAllHistory() async {
    await prismaClient.history.deleteMany();

    final isEmpty =
        (prismaClient.history.findMany() as Map<String, dynamic>)['history'] ==
            '[]';

    if (isEmpty) {
      return Response.json(
        body: {
          'message': 'History succesfully cleared !',
        },
      );
    }

    return Response.json(body: {
      'message': 'History could not be cleared !',
    }, statusCode: 500);
  }

  @override
  Future<Response> deleteHistory(History history) async {
    await prismaClient.history.delete(
      where: HistoryWhereUniqueInput(id: history.id),
    );

    return Response.json(body: {
      'message': 'History succesfully deleted !',
    }, statusCode: 200);
  }

  @override
  Future<Response> getHistory() async {
    var history = prismaClient.history.findMany();

    return Response.json(
      body: {
        'message': 'History found !',
        'history': history,
      },
    );
  }

  @override
  Future<Response> deleteHistoryById(String id) async {
    var history = await prismaClient.history
        .findUnique(where: HistoryWhereUniqueInput(id: int.parse(id)));

    if (history == null) {
      return Response.json(
        body: {
          'message': 'History not found !',
        },
        statusCode: 404,
      );
    }

    await prismaClient.history
        .delete(where: HistoryWhereUniqueInput(id: int.parse(id)));

    history = await prismaClient.history
        .findUnique(where: HistoryWhereUniqueInput(id: int.parse(id)));

    if (history == null) {
      return Response.json(
        body: {
          'message': 'History succesfully deleted !',
        },
      );
    }
    return Response.json(
      body: {
        'message': 'History could not be deleted !',
      },
      statusCode: 500,
    );
  }

  @override
  Future<Response> getHistoryById(String id) async {
    final history = await prismaClient.history
        .findUnique(where: HistoryWhereUniqueInput(id: int.parse(id)));

    if (history == null) {
      return Response.json(
        body: {
          'message': 'History not found !',
        },
        statusCode: 404,
      );
    }

    return Response.json(
      body: {
        'message': 'History found !',
        'history': history as Map<String, dynamic>,
      },
    );
  }
}
