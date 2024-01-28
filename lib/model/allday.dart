import 'dart:convert';

import 'package:weather_app/core/helper/datetime_extension.dart';
import 'package:weather_app/model/city.dart';
import 'package:weather_app/model/weather.dart';

class AllDay {
  final String cod;
  final int message;
  final int cnt;
  final List<Weather> list;
  final City city;
  //get today weather
  List<Weather> get todayWeather => list.where((element) => element.dateTime.isToday).toList();
  //get tomorrow weather
  List<Weather> get tomorrowWeather => list.where((element) => element.dateTime.isTomorrow).toList();
  //get next days weather
  List<Weather> get nextDaysWeather =>
      list.where((element) => !element.dateTime.isToday && !element.dateTime.isTomorrow).toList();
  AllDay({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory AllDay.fromJson(String str) => AllDay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllDay.fromMap(Map<String, dynamic> json) => AllDay(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<Weather>.from(json["list"].map((x) => Weather.fromMap(x))),
        city: City.fromMap(json["city"]),
      );

  Map<String, dynamic> toMap() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toMap())),
        "city": city.toMap(),
      };
}
