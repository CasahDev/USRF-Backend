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
  Future<Response> getLastMatchByTeam(String teamId) async {


    final match = await prismaClient.match.findFirst(
      where: MatchWhereInput(
        teamId: PrismaUnion.$1(
          (await prismaClient.team.findFirst(
            where: TeamWhereInput(
              name: PrismaUnion.$1(
                StringFilter(
                  equals: PrismaUnion.$1(teamId),
                ),
              ),
            ),
          ))!
              .id! as IntNullableFilter,
        ),
      ),
      orderBy: const PrismaUnion.$2(
        MatchOrderByWithRelationInput(date: SortOrder.desc),
      ),
    );

    print('debug');

    if (match == null) {
      return Response.json(
        body: {'message': 'Match not found'},
        statusCode: 404,
      );
    } else {
      return Response.json(
        body: {
          'message': 'Match found',
          'match': {
            'match': match,
            'id': match.id,
            'team': match.team,
            'opponent': match.opponent,
            'teamScore': match.teamScore,
            'opponentScore': match.opponentScore,
            'date': match.date,
            'startingTime': match.startedTime,
            'isCup': match.isCup,
          },
        },
      );
    }
  }

  @override
  Future<Response> getNextMatchs() async {
    final teams = await prismaClient.team.findMany();

    final result = StringBuffer();
    for (final team in teams) {
      final match =
          await getLastMatchByTeam(team.name ?? '') as Map<String, dynamic>;
      result.write(match['match']);
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

    final match = await prismaClient.match.findFirst(
      where: MatchWhereInput(
        teamId: PrismaUnion.$1(data['teamId'] as IntNullableFilter),
        opponentId: PrismaUnion.$1(data['opponentId'] as IntFilter),
        teamScore: PrismaUnion.$1(data['teamScore'] as IntFilter),
        opponentScore: PrismaUnion.$1(data['opponentScore'] as IntFilter),
        date: PrismaUnion.$1(data['date'] as DateTimeFilter),
        address: PrismaUnion.$1(data['address'] as StringFilter),
        isHome: PrismaUnion.$1(data['isHome'] as BoolFilter),
        coach: PrismaUnion.$1(data['coach'] as StringFilter),
        state: PrismaUnion.$1(GameState.notStarted as EnumGameStateFilter),
        isCup: PrismaUnion.$1(data['isCup'] as BoolFilter),
        startedTime: PrismaUnion.$1(data['startedTime'] as DateTimeFilter),
      ),
      orderBy: const PrismaUnion.$2(
        MatchOrderByWithRelationInput(date: SortOrder.desc),
      ),
    );

    if (match == null) {
      return Response.json(
        body: {'message': 'Match could not be created'},
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
  Future<Response> getMatchs() async {
    final matchs = await prismaClient.match.findMany();
    return Response.json(
      body: {
        'message': 'Matchs found !',
        'matchs': matchs,
      },
    );
  }

  @override
  Future<Response> deleteMatch(int id) async {
    await prismaClient.match.delete(
      where: MatchWhereUniqueInput(id: id),
    );

    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: id),
    );

    if (match != null) {
      return Response.json(
        body: {'message': 'Match could not be deleted'},
        statusCode: 500,
      );
    }

    return Response.json(
      body: {
        'message': 'Match deleted !',
      },
    );
  }

  @override
  Future<Response> getMatchById(int id) async {
    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: id),
    );

    if (match == null) {
      return Response.json(
        body: {'message': 'Match not found'},
        statusCode: 404,
      );
    }

    return Response.json(
      body: {
        'message': 'Match found !',
        'match': {
          'team': match.team!.name,
          'opponent': match.opponent,
          'teamScore': match.teamScore,
          'opponentScore': match.opponentScore,
          'date': match.date,
          'address': match.address,
          'isHome': match.isHome,
          'coach': match.coach,
          'isCup': match.isCup,
        },
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
          isCup: PrismaUnion.$1(data['isCup'] as bool),
        ),
      ),
      where: MatchWhereUniqueInput(id: id),
    );

    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: id),
    );

    if (match?.teamScore != data['teamScore'] as int ||
        match?.opponentScore != data['opponentScore'] as int ||
        match?.date != data['date'] as DateTime ||
        match?.address != data['address'] as String ||
        match?.isHome != data['isHome'] as bool ||
        match?.coach != data['coach'] as String ||
        match?.state != data['state'] as GameState ||
        match?.isCup != data['isCup'] as bool) {
      return Response.json(
        body: {'message': 'Match could not be updated'},
        statusCode: 500,
      );
    }

    return Response.json(
      body: {
        'message': 'Match updated !',
      },
    );
  }

  @override
  Future<Response> changeMatchState(int id, Map<String, dynamic> data) async {
    var match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: id),
    );

    if (match == null) {
      return Response.json(
        body: {'message': 'Match not found'},
        statusCode: 404,
      );
    }

    await prismaClient.match.update(
      data: PrismaUnion.$1(
        MatchUpdateInput(
          state: PrismaUnion.$1(data['state'] as GameState),
        ),
      ),
      where: MatchWhereUniqueInput(id: id),
    );

    final matchState = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: id),
    );

    if (matchState?.state != data['state'] as GameState) {
      return Response.json(
        body: {'message': 'Match state could not be updated'},
        statusCode: 500,
      );
    }

    return Response.json(
      body: {
        'message': 'Match state updated !',
      },
    );
  }

  @override
  Future<Response> getMatchState(int id) async {
    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(
        id: id,
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
        'message': 'Match state found !',
        'state': match.state,
      },
    );
  }

  @override
  Future<Response> deleteLastAction(int matchId) async {
    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: matchId),
    );

    if (match == null) {
      return Response.json(
        body: {'message': 'Match not found'},
        statusCode: 404,
      );
    }

    final lastAction = await prismaClient.matchHistory.findFirst(
      where: MatchHistoryWhereInput(
        matchId: PrismaUnion.$1(match.id! as IntFilter),
      ),
      orderBy: const PrismaUnion.$2(
        MatchHistoryOrderByWithRelationInput(
          time: SortOrder.desc,
        ),
      ),
    );

    if (lastAction == null) {
      return Response.json(
        body: {'message': 'Last action not found'},
        statusCode: 404,
      );
    }

    await prismaClient.matchHistory.delete(
      where: MatchHistoryWhereUniqueInput(id: lastAction.id!),
    );

    final action = await prismaClient.matchHistory.findUnique(
      where: MatchHistoryWhereUniqueInput(id: lastAction.id!),
    );

    if (action != null) {
      return Response.json(
        body: {'message': 'Last action could not be deleted'},
        statusCode: 500,
      );
    }

    return Response.json(
      body: {
        'message': 'Last action deleted !',
      },
    );
  }

  @override
  Future<Response> getLastAction(int matchId) async {

    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: matchId),
    );

    if (match == null) {
      return Response.json(
        body: {'message': 'Match not found'},
        statusCode: 404,
      );
    }

    final action = await prismaClient.matchHistory.findFirst(
      where: MatchHistoryWhereInput(
        matchId: PrismaUnion.$1(match.id! as IntFilter),
      ),
      orderBy: const PrismaUnion.$2(
        MatchHistoryOrderByWithRelationInput(
          time: SortOrder.desc,
        ),
      ),
    );

    if (action == null) {
      return Response.json(
        body: {'message': 'Last action not found'},
        statusCode: 404,
      );
    }

    final infos = action.additionnalInformations! as Map<String, dynamic>;

    return Response.json(
      body: {
        'message': 'Last action found !',
        'action': {
          'id': action.id,
          'matchId': action.matchId,
          'time': action.time,
          'action': action.eventType,
          'player': infos['player'],
          'team': infos['team'],
        },
      },
    );
  }
}
