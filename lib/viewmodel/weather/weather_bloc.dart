import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/location/location_service.dart';
import 'package:weather_app/model/allday.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather/weather_service_interface.dart';
import 'package:weather_app/services/weather_cache/weather_cache_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherServiceI weatherServiceInterface;
  final WeatherCacheService weatherCacheService;
  final Connectivity connectivity;
  final LocationService geolocator;
  WeatherBloc({
    required this.weatherServiceInterface,
    required this.weatherCacheService,
    required this.connectivity,
    required this.geolocator,
  }) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetCurrentWeather) {
        emit(WeatherLoading());
        try {
          var position = await geolocator.getCurrentLocation();
          // print(position);
          var connected = await connectivity.checkConnectivity();
          if (connected == ConnectivityResult.none) {
            var weather = await weatherCacheService.getLastCachedWeather();
            var allDay = await weatherCacheService.getLastCachedAllDayWeather();
            if (weather != null && allDay != null) {
              emit(WeatherLoaded(Weather.fromJson(weather), AllDay.fromJson(allDay)));
            } else {
              emit(WeatherError('Failed to load weather data'));
            }
          } else {
            var weather = await weatherServiceInterface.fetchWeatherByPostion(position);
            var allDay = await weatherServiceInterface.fetchWeatherByAllDaysPosition(position);
            await weatherCacheService.cacheWeather(weather.name, weather.toJson());
            await weatherCacheService.cacheAllDayWeather(weather.name, allDay.toJson());

            emit(WeatherLoaded(weather, allDay));
          }
        } on Exception catch (e) {
          emit(WeatherError(e.toString()));
        }
      } else if (event is SearchWeather && state is WeatherLoaded) {
        WeatherLoaded state = this.state as WeatherLoaded;
        emit(WeatherLoading());
        if (event.query.isEmpty) {
          emit(WeatherLoaded(state.weather, state.allDay));
          return;
        }
        try {
          var weathers = await weatherServiceInterface.fetchWeatherByName(event.query);
          var allDay = await weatherServiceInterface.fetchWeatherByAllDays(event.query);
          await weatherCacheService.cacheWeather(event.query, weathers.toJson());
          await weatherCacheService.cacheAllDayWeather(event.query, allDay.toJson());
          emit(WeatherSearchLoaded(state.weather, state.allDay, weathers, allDay));
        } catch (e) {
          var weather = await weatherCacheService.getCachedWeather(event.query);
          var allDay = await weatherCacheService.getCachedAllDayWeather(event.query);
          if (weather != null && allDay != null) {
            emit(WeatherSearchLoaded(state.weather, state.allDay, weather, allDay));
          } else {
            emit(WeatherErrorSearch(state.weather, state.allDay, e.toString()));
          }
        }
      }
    });
  }
}
