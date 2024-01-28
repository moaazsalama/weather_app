part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final String cityName;
  GetWeather(this.cityName);
}
class GetCurrentWeather extends WeatherEvent {
  // final String cityName;
  GetCurrentWeather();
}
class SearchWeather extends WeatherEvent {
  final String query;
  SearchWeather(this.query);
}