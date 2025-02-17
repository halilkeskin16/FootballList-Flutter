import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_list/models/country_league.dart';
import 'package:football_list/models/europe_country.dart';
import 'package:football_list/models/league_scoreboard.dart';

class ApiService {
  static final String apiKey = dotenv.env['API_KEY'] ?? '';

  static Future<List<CountryLeagueModel>> getLeaguesByCountry(int countryId) async {
    const String url = 'https://api.football-data.org/v4/competitions';
    Dio dio = Dio();
    final response = await dio.get(url, options: Options(headers: {'X-Auth-Token': apiKey}));

    if (response.data is Map && response.data.containsKey('competitions')) {
      final List<dynamic> leagues = response.data['competitions'];
      return leagues
          .map((item) => CountryLeagueModel.fromMap(item))
          .where((league) => league.area.id == countryId)
          .toList();
    }

    throw Exception('Unexpected JSON format');
  }

  static Future<List<EuropeCountryModel>> getEuropeCountry() async {
    const String url = 'https://api.football-data.org/v4/areas/';
    Dio dio = Dio();
    final response = await dio.get(url, options: Options(headers: {'X-Auth-Token': apiKey}));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data['areas'];
      return jsonData
          .where((item) => item['parentArea'] == 'Europe')
          .map((item) => EuropeCountryModel.fromJson(item))
          .toList();
    }
    throw Exception('Failed to load data. Status Code: ${response.statusCode}');
  }

  static Future<LeagueScoreboard> getLeagueScoreboard(int competitionId) async {
    final String url =
        "http://api.football-data.org/v4/competitions/$competitionId/standings";
    Dio dio = Dio();
    final response = await dio.get(url, options: Options(headers: {'X-Auth-Token': apiKey}));
    if (response.statusCode == 200) {
      return LeagueScoreboard.fromJson(response.data);
    }
    throw Exception('Hata ${response.statusCode}');
  }
}
