import 'package:dart_frog/src/_internal.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/model.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Interface/IMatchDAO.dart';

class MatchDAO implements IMatchDAO {
  MatchDAO() {
    prismaClient = PrismaClient();
  }

  late PrismaClient prismaClient;

  @override
  Future<Response> getLastMatchByTeam(int teamId) async {
    final match = await prismaClient.match.findFirst(
      where: MatchWhereInput(
        teamId: PrismaUnion.$1(
          teamId as IntNullableFilter,
        ),
      ),
      orderBy: const PrismaUnion.$2(
        MatchOrderByWithRelationInput(date: SortOrder.desc),
      ),
    );
    if (match == null) {
      return Response.json(
        body: {'message': 'Match not found'},
        statusCode: 404,
      );
    }
    return Response.json(
      body: {
        'message': 'Match found',
        'match': {
          'id': match.id,
          'team': match.team,
          'opponent': match.opponent,
          'teamScore': match.teamScore,
          'opponentScore': match.opponentScore,
          'date': match.date,
          'startingTime' : match.startedTime,
          'isCup' : match.isCup,
        },
      },
    );
  }

  @override
  Future<Response> getNextMatchs() async {
    final teamCount =
        await prismaClient.$raw.query('SELECT COUNT(*) FROM Team;');

    final result = StringBuffer();
    for (var i = 0; i < teamCount.length; i++) {
      final match = await getLastMatchByTeam(i + 1);
      result.write((await match.json())['match']);
    }

    return Response.json(
      body: {
        'message': 'Matchs found',
        'matchs': {result},
      },
    );
  }

  @override
  Future<Response> createMatch(Map<String, dynamic> data) async {
    try {
      await prismaClient.match.create(
        data: PrismaUnion.$1(
          MatchCreateInput(
            team: TeamCreateNestedOneWithoutMatchesInput(
              connect: TeamWhereUniqueInput(id: data['teamId'] as int),
            ),
            opponent: OpponentCreateNestedOneWithoutMatchesInput(
              connect: OpponentWhereUniqueInput(id: data['opponentId'] as int),
            ),
            teamScore: data['teamScore'] as int,
            opponentScore: data['opponentScore'] as int,
            date: data['date'] as DateTime,
            address: data['address'] as String,
            isHome: data['isHome'] as bool,
            coach: data['coach'] as String,
            state: GameState.notStarted,
            isCup: data['isCup'] as bool,
            startedTime: data['startedTime'] as DateTime,
          ),
        ),
      );
    } catch (e) {
      return Response.json(
        body: {'message': 'Match could not be created (error: $e)'},
        statusCode: 500,
      );
    }
    return Response.json(
      body: {
        'message': 'Matchs succesfly created',
      },
    );
  }

  @override
  Future<Response> getMatchById(int matchId) async {
    try {
      final match = await prismaClient.match.findFirst(
        where: MatchWhereInput(id: PrismaUnion.$1(matchId as IntFilter)),
      );

      return Response.json(
        body: {
          'message': 'Match found !',
          'match': {
            'team': match?.team!.name,
            'opponent': match?.opponent,
            'teamScore': match?.teamScore,
            'opponentScore': match?.opponentScore,
            'date': match?.date,
            'address': match?.address,
            'isHome': match?.isHome,
            'coach': match?.coach,
          },
        },
      );
    } catch (e) {
      return Response.json(
        body: {
          'message': e.toString(),
        },
      );
    }
  }

  @override
  Future<Response> deleteMatch(int id) async {
    await prismaClient.match.delete(
      where: MatchWhereUniqueInput(id: id),
    );

    return Response.json(
      body: {
        'message': 'Match deleted !',
      },
    );
  }

  @override
  Future<Response> getMatchs() async {
    var matchs = await prismaClient.match.findMany();
    return Response.json(
      body: {
        'message': 'Matchs found !',
        'matchs': matchs,
      },
    );
  }

  @override
  Future<Response> updateMatch(int id, Map<String, dynamic> data) async {
    await prismaClient.match.update(
      data: PrismaUnion.$1(
        MatchUpdateInput(
          teamScore: PrismaUnion.$1(data['teamScore'] as int),
          opponentScore: PrismaUnion.$1(data['opponentScore'] as int),
          date: PrismaUnion.$1(data['date'] as DateTime),
          address: PrismaUnion.$1(data['address'] as String),
          isHome: PrismaUnion.$1(data['isHome'] as bool),
          coach: PrismaUnion.$1(data['coach'] as String),
          state: PrismaUnion.$1(data['state'] as GameState),
        ),
      ),
      where: MatchWhereUniqueInput(id: id),
    );

    return Response.json(
      body: {
        'message': 'Match updated !',
      },
    );
  }
}
