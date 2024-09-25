import 'package:dart_frog/src/_internal.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/model.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Interface/IHistoryDAO.dart';

class HistoryDAO implements IHistoryDAO {
  HistoryDAO() {
    prismaClient = PrismaClient();
  }

  late PrismaClient prismaClient;

  @override
  Future<Response> getMatchHistory(String matchId) async {
    final history = await prismaClient.history.findMany(
      where: HistoryWhereInput(
        additionnalInformations: PrismaUnion.$1(
          StringFilter(contains: PrismaUnion.$1(matchId)),
        ),
      ),
    );

    if (history.isEmpty) {
      return Response.json(
        body: {
          'message': 'No history found for this match',
        },
      );
    }

    return Response.json(
      body: {
        'message': 'History found !',
        'history': history,
      },
    );
  }

  @override
  Future<Response> addHistory(History history) async {
    await prismaClient.history.create(
      data: PrismaUnion.$1(
        HistoryCreateInput(
          additionnalInformations: history.additionnalInformations!,
          actionType: history.actionType!,
        ),
      ),
    );

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
        (prismaClient.history.findMany() as Map<String, dynamic>)["history"] ==
            "[]";

    if (isEmpty) {
      return Response.json(
        body: {
          'message': 'History succesfully cleared !',
        },
      );
    }

    return Response.json(
      body: {
        'message': 'History could not be cleared !',
      },
    );
  }

  @override
  Future<Response> deleteHistory(History history) async {
    await prismaClient.history.delete(
      where: HistoryWhereUniqueInput(id: history.id),
    );

    return Response.json(
      body: {
        'message': 'History succesfully deleted !',
      },
    );
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
  Future<Response> addEventToMatchHistory(
      String id, Map<String, dynamic> body) async {
    await prismaClient.history.create(
      data: PrismaUnion.$1(
        HistoryCreateInput(
          additionnalInformations: body['additionnalInformations'] as String,
          actionType: body['actionType'] as ActionType,
          author: body["author"] as UserCreateNestedOneWithoutHistoryInput,
        ),
      ),
    );

    return Response.json(
      body: {
        'message': 'Event added to match history',
      },
    );
  }
}
