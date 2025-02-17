import 'package:flutter/material.dart';
import 'package:football_list/models/league_scoreboard.dart';
import 'package:football_list/services/service.dart';

class LeagueScoreboardPage extends StatefulWidget {
  final int leagueId;
  final String leagueName;
  const LeagueScoreboardPage({super.key, required this.leagueId, required this.leagueName});

  @override
  State<LeagueScoreboardPage> createState() => _LeagueScoreboardPageState();
}

class _LeagueScoreboardPageState extends State<LeagueScoreboardPage> {
  late Future<LeagueScoreboard> _futureLeagueScoreboard;
  bool isLandscape = false;
  @override
  void initState() {
    super.initState();
    _futureLeagueScoreboard = ApiService.getLeagueScoreboard(widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      isLandscape = constraints.maxWidth > constraints.maxHeight;
      return Scaffold(
        appBar: AppBar(title: Text(widget.leagueName)),
        body: FutureBuilder<LeagueScoreboard>(
          future: _futureLeagueScoreboard,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data == null ||
                snapshot.data!.standings.isEmpty) {
              return const Center(child: Text('Takımlar Listelenemedi'));
            }
            final leagueData = snapshot.data!;
            final standings = leagueData.standings;

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ScoreWidget(text: 'Pos'),
                      Container(
                        width: 30,
                        child: Text(''),
                      ),
                      Expanded(
                        child: Text('Team'),
                      ),
                      Visibility(
                        visible: isLandscape,
                        child: ScoreWidget(text: 'W'),
                      ),
                      Visibility(
                        visible: isLandscape,
                        child: ScoreWidget(text: 'D'),
                      ),
                      Visibility(
                        visible: isLandscape,
                        child: ScoreWidget(text: 'L'),
                      ),
                      Visibility(
                        visible: isLandscape,
                        child: ScoreWidget(text: 'GF'),
                      ),
                      ScoreWidget(text: 'GA'),
                      ScoreWidget(text: 'Pts'),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: standings.length,
                    itemBuilder: (context, index) {
                      final teamData = standings[index];
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ScoreWidget(text: teamData.position.toString()),
                            Container(
                              width: 30,
                              child: Image.network(
                                teamData.flag ?? '',
                                fit: BoxFit.contain,
                                width: 24,
                                height: 24,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                teamData.teamName,
                                style: TextStyle(letterSpacing: -0.5),
                              ),
                            ),
                            Visibility(
                              visible: isLandscape,
                              child: ScoreWidget(text: teamData.won.toString()),
                            ),
                            Visibility(
                              visible: isLandscape,
                              child: ScoreWidget(text: teamData.draw.toString()),
                            ),
                            Visibility(
                              visible: isLandscape,
                              child: ScoreWidget(text: teamData.lost.toString()),
                            ),
                            Visibility(
                              visible: isLandscape,
                              child: ScoreWidget(text: teamData.goalsFor.toString()),
                            ),
                            ScoreWidget(text: teamData.goalsAgainst.toString()),
                            ScoreWidget(text: teamData.points.toString()),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
