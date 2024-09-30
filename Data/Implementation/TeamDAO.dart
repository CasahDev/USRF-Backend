import 'package:dart_frog/dart_frog.dart';
import 'package:orm/orm.dart';

import '../../prisma/generated_dart_client/client.dart';
import '../../prisma/generated_dart_client/prisma.dart';
import '../Data.dart';
import '../Interface/ITeamDAO.dart';

class TeamDAO implements ITeamDAO {
  late PrismaClient prismaClient;

  TeamDAO() {
    prismaClient = Data.getDAO();
  }

  @override
  Future<Response> createTeam(Map<String, dynamic> body) async {
    final team = await prismaClient.team.create(
      data: PrismaUnion.$1(
        TeamCreateInput(
          name: body['name'] as String,
          fffId: int.parse(body['fffId'] as String),
        ),
      ),
    );

    final teamCheck = await prismaClient.team.findUnique(
      where: TeamWhereUniqueInput(id: team.id),
    );

    if (teamCheck == null) {
      return Response(body: 'Team not created', statusCode: 500);
    }

    return Response(body: 'Team created', statusCode: 201);
  }

  @override
  Future<Response> getTeams() async {
    return Response(body: 'getTeams');
  }
}
