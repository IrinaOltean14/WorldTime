import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  late String location; //location name for the UI
  late String time; // the time in the location
  late String flag; // url to an asset flag
  late String url; // the location url for api endpoint
  late bool isDayTime; // true or false is daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try{
      Uri u = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(u);
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      time = 'coud not get time data';
    }
  }
}
