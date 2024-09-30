import 'package:dart_frog/dart_frog.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/model.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Data.dart';
import '../Interface/IMatchHistoryDAO.dart';

class MatchHistoryDAO implements IMatchHistoryDAO {
  MatchHistoryDAO() {
    prismaClient = Data.getDAO();
  }

  late PrismaClient prismaClient;

  @override
  Future<Response> addEventToMatchHistory(
      String id, Map<String, dynamic> body) async {
    var match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: int.parse(id)),
    );

    if (match == null) {
      return Response.json(
        body: {
          'message': 'No match found with this id',
        },
        statusCode: 404,
      );
    }

    var history = await prismaClient.matchHistory.create(
      data: PrismaUnion.$1(
        MatchHistoryCreateInput(
          additionnalInformations: body['additionnalInformations'] as String,
          eventType: body['actionType'] as MatchEvent,
          match: MatchCreateNestedOneWithoutMatchHistoryInput(
            connect: MatchWhereUniqueInput(id: match.id),
          ),
          time: body['createdAt'] as DateTime,
        ),
      ),
    );

    if (body.isEmpty) {
      return Response.json(
        body: {
          'message': 'No event found for this match',
        },
        statusCode: 404,
      );
    }

    final historyAdded = await prismaClient.matchHistory
        .findUnique(where: MatchHistoryWhereUniqueInput(id: history.id));

    if (historyAdded == null) {
      return Response.json(
        body: {
          'message': 'Event could not be added',
        },
        statusCode: 500,
      );
    }

    return Response.json(
      body: {
        'message': 'Event succesfully added !',
      },
    );
  }

  @override
  Future<Response> getMatchHistory(String matchId) async {
    final history = await prismaClient.matchHistory.findMany(
      where: MatchHistoryWhereInput(
        matchId: PrismaUnion.$1(
          IntFilter(
            equals: PrismaUnion.$1(
              int.parse(matchId),
            ),
          ),
        ),
      ),
    );

    if (history.isEmpty) {
      return Response.json(
        body: {
          'message': 'No history found for this match',
        },
        statusCode: 404,
      );
    }

    return Response.json(
      body: {
        'message': 'History found !',
        'history': history,
      },
    );
  }
}
