
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../data/countries_abreviation.dart';

class WorldTime{

  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({required this.location, required this.url ,required this.flag}): time = '' ,isDaytime=true;

  CountriesAbreviation countriesAbreviation = CountriesAbreviation();

  Future<void> getData() async{
    try{
      // Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      // Map data = jsonDecode(response.body);
      Map timeDeats = jsonDecode(response.body);
      // print(timeDeats);

      //get Properties from json data
      String dateTime = timeDeats['datetime'];
      String offset = timeDeats['utc_offset'].substring(1,3);
      int newOffset = int.parse(offset);
      // print(dateTime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: newOffset));
      // print("now is $now");
      //data of the country short value for flag api
      String countryShortForFlag = countriesAbreviation.countriesAbbreviation["Kenya"];


      time = DateFormat.jm().format(now).toString();
      // time = now.toString();
      url ="helllo/universe";
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;

    }catch(e){
      time = "could not get data";
    }
  }

//TODO: time api http://worldtimeapi.org/api/timezone/


}

