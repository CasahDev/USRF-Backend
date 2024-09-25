import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Interface/IPlayedDAO.dart';

class PlayedDAO implements IPlayedDAO {
  PlayedDAO() {
    prismaClient = PrismaClient();
  }

  late PrismaClient prismaClient;

  @override
  Future<Response> addPlayerToLineUp(int playerId, String id) async {
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
