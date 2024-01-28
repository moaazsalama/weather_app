import 'package:weather_app/core/database/database.dart';
import 'package:weather_app/model/allday.dart';
import 'package:weather_app/model/weather.dart';

class WeatherCacheService {
  // final EncryptionService _encryptionService;
  final WeatherDatabase _weatherDatabase;

  WeatherCacheService({required WeatherDatabase weatherDatabase}) : _weatherDatabase = weatherDatabase;

  Future<void> cacheWeather(String city, String jsonWeather) async {
    await _weatherDatabase.open();
    await _weatherDatabase.cacheWeather(city, jsonWeather);
  }

  Future<Weather?> getCachedWeather(String city) async {
    await _weatherDatabase.open();
    var cachedWeather = await _weatherDatabase.getCachedWeather(city);
    if (cachedWeather != null) {
      return Weather.fromJson(cachedWeather);
    }
  }

  Future<void> cacheAllDayWeather(String name, String json) async {
    await _weatherDatabase.open();
    await _weatherDatabase.cacheAllDayWeather(name, json);
  }

  Future<AllDay?> getCachedAllDayWeather(String query) async {
    await _weatherDatabase.open();
    var result = await _weatherDatabase.getCachedAllDayWeather(query);
    if (result != null) {
      return AllDay.fromJson(result);
    }
  }

  Future<String?> getLastCachedWeather() async {
    await _weatherDatabase.open();
    var result = await _weatherDatabase.getLastCachedWeather();
    return result;
  }

  Future<String?> getLastCachedAllDayWeather() async {
    await _weatherDatabase.open();
    var result = await _weatherDatabase.getLastCachedAllDayWeather();
    return result;
  }
}
