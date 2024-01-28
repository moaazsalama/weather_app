import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:weather_app/core/api/api_calls/api_calls_interface.dart';
import 'package:weather_app/core/api/api_keys.dart';
import 'package:weather_app/core/api/api_paths.dart';
import 'package:weather_app/model/allday.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather/weather_service_interface.dart';

class WeatherServiceImpl implements WeatherServiceI {
  final ApiCallsI provider;

  WeatherServiceImpl({required ApiCallsI dio}) : provider = dio;
  Future<Map<String, dynamic>> getGeoLocation(String cityName) async {
    var result = await provider.get(ApiPaths.getGeoUrl,
        options: ApiOptions(queryParameters: {
          'q': cityName,
          'limit': 1,
          'appid': ApiKeys.weaetherApiKeys,
        }));
    if (result.statusCode == StatusCode.success) {
      return result.data[0];
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<Weather> fetchWeatherByName(String cityName) async {
    try {
      var geoLocation = await getGeoLocation(cityName);
      var location = geoLocation['lat'];
      var lon = geoLocation['lon'];
      var result = await provider.get(ApiPaths.getCurrentWeather,
          options: ApiOptions(queryParameters: {
            'lat': location,
            'lon': lon,
            'appid': ApiKeys.weaetherApiKeys,
          }));
      if (result.statusCode == StatusCode.success) {
        return Weather.fromMap(result.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on Exception catch (_) {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<Weather> fetchWeatherByPostion(Position position) async {
    try {
      // var geoLocation = await getGeoLocation(cityName);
      var location = position.latitude;
      var lon = position.longitude;
      var result = await provider.get(ApiPaths.getCurrentWeather,
          options: ApiOptions(queryParameters: {
            'lat': location,
            'lon': lon,
            'appid': ApiKeys.weaetherApiKeys,
          }));
      if (result.statusCode == StatusCode.success) {
        return Weather.fromMap(result.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on Exception catch (_) {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<AllDay> fetchWeatherByAllDays(String cityName) async {
    try {
      var geoLocation = await getGeoLocation(cityName);
      var location = geoLocation['lat'];
      var lon = geoLocation['lon'];
      var result = await provider.get(ApiPaths.getWeatherByAllDays,
          options: ApiOptions(queryParameters: {
            'lat': location,
            'lon': lon,
            'appid': ApiKeys.weaetherApiKeys,
          }));
      if (result.statusCode == StatusCode.success) {
        return AllDay.fromMap(result.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on Exception catch (_) {
      throw Exception('Failed to load weather data');
    }
    
  }

  @override
  Future<AllDay> fetchWeatherByAllDaysPosition(Position position) async{
    try {
      var location = position.latitude;
      var lon = position.longitude;
      var result = await provider.get(ApiPaths.getWeatherByAllDays,
          options: ApiOptions(queryParameters: {
            'lat': location,
            'lon': lon,
            'appid': ApiKeys.weaetherApiKeys,
          }));
          print(result.data);
          print(result.statusCode)  ;
      if (result.statusCode == StatusCode.success) {
        return AllDay.fromMap(result.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } on Exception catch (e) {
      print(e);
      throw Exception('Failed to load weather data');
    }
   
  }
}
