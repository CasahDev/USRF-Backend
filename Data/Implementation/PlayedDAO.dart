import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Data.dart';
import '../Interface/IPlayedDAO.dart';

class PlayedDAO implements IPlayedDAO {
  PlayedDAO() {
    prismaClient = Data.getDAO();
  }

  late PrismaClient prismaClient;

  @override
  Future<Response> addPlayerToLineUp(int playerId, String id) async {

    final player = await prismaClient.player.findUnique(
      where: PlayerWhereUniqueInput(id: playerId),
    );

    if (player == null) {
      return Response.json(
        body: {
          'message': 'Player not found',
        },
        statusCode: 404,
      );
    }

    final match = await prismaClient.match.findUnique(
      where: MatchWhereUniqueInput(id: int.parse(id)),
    );

    if (match == null) {
      return Response.json(
        body: {
          'message': 'Match not found',
        },
        statusCode: 404,
      );
    }

    final played = await prismaClient.played.findUnique(
      where: PlayedWhereUniqueInput(
        matchId: PrismaUnion.$1(int.parse(id) as IntFilter),
        playerId: PrismaUnion.$1(playerId as IntFilter),
      ),
    );

    if (played != null) {
      return Response.json(
        body: {
          'message': 'Player already in the lineup',
        },
        statusCode: 400,
      );
    }

    await prismaClient.played.create(
      data: PrismaUnion.$1(
        PlayedCreateInput(
          player: PlayerCreateNestedOneWithoutPlayedInput(
            connect: PlayerWhereUniqueInput(id: playerId),
          ),
          match: MatchCreateNestedOneWithoutPlayedInput(
            connect: MatchWhereUniqueInput(id: int.parse(id)),
          ),
          assists: 0,
          blocked: 0,
          goals: 0,
          offTarget: 0,
          red: false,
          onTarget: 0,
          yellow: false,
          jerseyNumber: 0,
          entryTime: DateTime(2024),
          leaveTime: DateTime(2024),
        ),
      ),
    );

    return Response.json(
      body: {
        'message': 'Player added to lineup',
      },
    );
  }

  @override
  Future<Response> getLineup(String matchId) async {
    final lineup = await prismaClient.played.findMany(
        where: PlayedWhereInput(id: PrismaUnion.$1(matchId as IntFilter)));
    final response = deserializeJsonResponse(lineup);

    var message = 'Lineup found !';
    if (response == '') {
      message = 'Lineup not found !';
    }

    return Response.json(
      body: {
        'message': message,
        'lineup': jsonEncode(response),
      },
    );
  }
}
