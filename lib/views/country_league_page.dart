import 'package:flutter/material.dart';
import 'package:football_list/models/country_league.dart';
import 'package:football_list/services/service.dart';
import 'package:football_list/views/league_score_page.dart';

class CountryLeaguesPage extends StatefulWidget {
  final int countryId;
  final String countryName;
  const CountryLeaguesPage({super.key, required this.countryId, required this.countryName});

  @override
  State<CountryLeaguesPage> createState() => _CountryLeaguesPageState();
}

class _CountryLeaguesPageState extends State<CountryLeaguesPage> {
  late Future<List<CountryLeagueModel>> _futureLeagues;
  int leagueId = 0;
  String leagueName = '';

  @override
  void initState() {
    super.initState();
    _futureLeagues = ApiService.getLeaguesByCountry(widget.countryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.countryName}')),
      body: FutureBuilder<List<CountryLeagueModel>>(
         
        future: _futureLeagues,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}')); 
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Ligler Listenemedi')); 
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              
              return ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].area.name),
                leading: snapshot.data![index].emblem != null
                    ? Image.network(snapshot.data![index].emblem!, width: 40, height: 40) 
                    : const Icon(Icons.sports_soccer), 
                onTap: () {
                  leagueId = snapshot.data![index].id;
                  leagueName = snapshot.data![index].name;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LeagueScoreboardPage(leagueId: leagueId, leagueName: leagueName)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
