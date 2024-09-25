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
          StringFilter(contains: PrismaUnion.$1(matchId)),),),
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
    // TODO: implement addHistory
    throw UnimplementedError();
  }

  @override
  Future<Response> deleteAllHistory() async {
    // TODO: implement deleteAllHistory
    throw UnimplementedError();
  }

  @override
  Future<Response> deleteHistory(History history) async {
    // TODO: implement deleteHistory
    throw UnimplementedError();
  }

  @override
  Future<Response> getHistory() async {
    var history = prismaClient.history.findMany();

    return Response.json(body:
        {
          'message' : 'History found !',
          'history' : history,
        },
    );
  }


  @override
  Future<Response> addEventToMatchHistory(String id,
      Map<String, dynamic> body) async {
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
