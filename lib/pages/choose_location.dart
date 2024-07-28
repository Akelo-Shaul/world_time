
import 'package:flutter/material.dart';

import 'package:world_time/data/countries_abreviation.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [];
  List countriesZones = CountriesAbreviation().countriesZones;
  Map countriesAbreviation = CountriesAbreviation().countriesAbbreviation;

  @override
  void initState() {
    super.initState();
    printCountriesAbreviation();
  }

  void printCountriesAbreviation() {
    List<WorldTime> tempLocations = [];

    for (var s in countriesZones) {
      RegExp regExp = RegExp(r'\/([^\/]+)$');
      Match? match = regExp.firstMatch(s);

      String? loc;
      String? flagShort;
      if (match != null) {
        loc = match.group(1);

        if (loc != null && countriesAbreviation.containsKey(loc)) {
          flagShort = 'https://flagpedia.net/data/flags/w702/${countriesAbreviation[loc]}.webp';
        } else {
          flagShort = 'https://i.redd.it/a2a2qfnvhkf71.jpg';
        }
      } else {
        flagShort = 'https://i.redd.it/a2a2qfnvhkf71.jpg';
      }

      if (loc != null) {
        tempLocations.add(
          WorldTime(
            location: loc,
            url: s,
            flag: flagShort,
          ),
        );
      }
    }

    setState(() {
      locations = tempLocations;
    });
  }

  void updateTime(int index) async {
    WorldTime instance = locations[index];
    await instance.getData();

    // print(instance.location);

    // Pass the data back to the previous screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        title: const Text("Choose a Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(locations[index].flag),
              ),
            ),
          );
        },
      ),
    );
  }
}
