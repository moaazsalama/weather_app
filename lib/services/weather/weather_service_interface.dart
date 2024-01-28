import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/allday.dart';
import 'package:weather_app/model/weather.dart';

abstract class WeatherServiceI {
  Future<Weather> fetchWeatherByName(String cityName);
  Future<Weather> fetchWeatherByPostion(Position position);
  //get Weather by all days 
  Future<AllDay> fetchWeatherByAllDays(String cityName);
  Future<AllDay> fetchWeatherByAllDaysPosition(Position position);
}