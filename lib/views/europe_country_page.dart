import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:football_list/models/europe_country.dart';
import 'package:football_list/services/service.dart';
import 'package:football_list/views/country_league_page.dart';

class Europecountrypage extends StatefulWidget {
  const Europecountrypage({super.key});

  @override
  State<Europecountrypage> createState() => _EuropecountrypageState();
}

class _EuropecountrypageState extends State<Europecountrypage> {
  late Future<List<EuropeCountryModel>> _futureEuropeCountry;
  int countryId = 0;
  String countryName = '';
  @override
  void initState() {
    super.initState();
    _futureEuropeCountry = ApiService.getEuropeCountry();
  }
  
  // Future<List<EuropeCountryModel>> filterCountry() async {
  //   List<EuropeCountryModel> allCountry = await getEuropeCountry();
  //   List<EuropeCountryModel> filterCountry = [];
  //   for (var i in allCountry){
  //     List<CountryLeagueModel> leagues = await getLeaguesByCountry(i.id);
  //     if(leagues.isNotEmpty){
  //       filterCountry.add(i);
  //     }
  //   }
  //   return filterCountry;
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<EuropeCountryModel>>(
      future: _futureEuropeCountry,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  countryId=snapshot.data![index].id;
                  countryName=snapshot.data![index].name;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CountryLeaguesPage(countryId: countryId , countryName: countryName)));     
                  },
                title: Text(snapshot.data![index].name),
                leading: snapshot.data![index].flag==null || snapshot.data![index].flag!.isEmpty ? Icon(Icons.warning) :  SvgPicture.network(
                  snapshot.data![index].flag!,
                  placeholderBuilder: (BuildContext context) => const Icon(Icons.error),
                  height: 30.0,
                ),
              );
            },
          );
        }
      },
    ));
  }
}
