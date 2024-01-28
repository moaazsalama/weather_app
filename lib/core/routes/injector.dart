import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/core/api/api_calls/api_calls.dart';
import 'package:weather_app/core/api/api_calls/api_calls_interface.dart';
import 'package:weather_app/core/database/database.dart';
import 'package:weather_app/core/encrypt/encrypt.dart';
import 'package:weather_app/core/location/location_service.dart';
import 'package:weather_app/services/weather/weather_service.dart';
import 'package:weather_app/services/weather/weather_service_interface.dart';
import 'package:weather_app/services/weather_cache/weather_cache_service.dart';
import 'package:weather_app/viewmodel/bloc/app_bloc.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';

List<Bind> get injector {
  //Dio
  return [
    Bind.singleton<Connectivity>((i) => Connectivity()),
    Bind.singleton<LocationService>((i) => LocationService()),
    Bind.singleton<Dio>((i) => Dio()),
    Bind.singleton<ApiCallsI>(
      (i) => ApiCallsImpl(i.get<Dio>()),
    ),
    Bind.singleton<EncryptionService>((i) => EncryptionService('my 32 length key................')),
    Bind.singleton<WeatherDatabase>((i) => WeatherDatabase(i.get<EncryptionService>())),
    Bind.singleton<WeatherServiceI>(
      (i) => WeatherServiceImpl(dio: i.get<ApiCallsI>()),
    ),
    Bind.singleton<WeatherCacheService>((i) => WeatherCacheService(weatherDatabase: i.get<WeatherDatabase>())),
    Bind.singleton<WeatherBloc>(
      (i) => WeatherBloc(
          connectivity: i.get<Connectivity>(),
          geolocator: i.get<LocationService>(),
          weatherCacheService: i.get<WeatherCacheService>(),
          weatherServiceInterface: i.get<WeatherServiceI>()),
    ),
    Bind.singleton<AppBloc>((i) => AppBloc()),
  ];
}
