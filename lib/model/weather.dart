import 'dart:convert';

import 'package:weather_app/model/Main.dart';
import 'package:weather_app/model/cloud.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/rain.dart';
import 'package:weather_app/model/sys.dart';
import 'package:weather_app/model/weather_element.dart';
import 'package:weather_app/model/wind.dart';

class Weather {
  final Coord? coord;
  final List<WeatherElement> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int? timezone;
  final int id;
  final String name;
  final int cod;
  final String? dtTxt;
  DateTime get dateTime=>dtTxt==null? DateTime.now():DateTime.parse(dtTxt!);
  Weather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
    this.dtTxt,
  });

  factory Weather.fromJson(String str) => Weather.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
        weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromMap(x))),
        base: json["base"]??json["dt_txt"],
        main: Main.fromMap(json["main"]),
        visibility: json["visibility"],
        wind: Wind.fromMap(json["wind"]),
        rain: json["rain"] == null ? null : Rain.fromMap(json["rain"]),
        clouds: Clouds.fromMap(json["clouds"]),
        dt: json["dt"],
        sys: Sys.fromMap(json["sys"]),
        timezone: json["timezone"],
        id: json["id"]??0,
        name: json["name"]??'',
        cod: json["cod"]??0,
        dtTxt: json["dt_txt"]??'',
      );

  Map<String, dynamic> toMap() => {
        "coord": coord?.toMap(),
        "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
        "base": base,
        "main": main.toMap(),
        "visibility": visibility,
        "wind": wind.toMap(),
        "rain": rain?.toMap(),
        "clouds": clouds.toMap(),
        "dt": dt,
        "sys": sys.toMap(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
        'dt_txt': dtTxt??''
        
      };

  @override
  String toString() {
    return 'Weather(coord: $coord, weather: $weather, base: $base, main: $main, visibility: $visibility, wind: $wind, rain: $rain, clouds: $clouds, dt: $dt, sys: $sys, timezone: $timezone, id: $id, name: $name, cod: $cod)';
  }
}
