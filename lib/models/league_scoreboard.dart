class LeagueScoreboard {
  final int competitionId;
  final List<Table> standings;

  LeagueScoreboard({required this.competitionId, required this.standings});

  factory LeagueScoreboard.fromJson(Map<String, dynamic> json) {
    List<dynamic> standingsJson = json['standings'] ?? [];
    List<Table> standingsList = [];
    for (var standing in standingsJson) {
      for (var table in standing['table']) {
        standingsList.add(Table.fromJson(table));
      }
    }
    return LeagueScoreboard(
      competitionId: json['competition']['id'],
      standings: standingsList,
    );
  }
}

class Table {
  final int position;
  final String teamName;
  final int points;
  final String? flag;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  Table(
 {
    required this.position,
    required this.teamName,
    required this.points,
    this.flag = '',
    required this.won,
    required this.draw,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.playedGames,
  });
  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      position: json['position'],
      teamName: json['team']['name'],
      points: json['points'],
      flag: json['team']['crest'], 
      won: json['won'],
      draw: json['draw'],
      lost: json['lost'],
      goalsFor: json['goalsFor'],
      goalsAgainst: json['goalsAgainst'],
      playedGames: json['playedGames'],
    );
  }
}
