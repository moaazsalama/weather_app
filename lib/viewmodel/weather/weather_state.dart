part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final Weather weather;
  final AllDay allDay;
  WeatherLoaded(this.weather, this.allDay);
  //equatable
  List<Object> get props => [weather, allDay];
}

final class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
final class WeatherErrorSearch extends WeatherLoaded {
  final String message;
  WeatherErrorSearch(super.weather, super.allDay, this.message);
}

final class WeatherSearchLoaded extends WeatherLoaded {
  final Weather result;
  final AllDay resultAllDay;
  WeatherSearchLoaded(super.weather, super.allDay, this.result, this.resultAllDay);
}
