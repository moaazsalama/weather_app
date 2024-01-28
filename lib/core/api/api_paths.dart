class ApiPaths{
 static const String _baseUrl = 'https://api.openweathermap.org';
//  static const String _baseUrl = 'http://api.openweathermap.org/geo/1.0/';
 static String get baseUrl => _baseUrl;
 static String get weatherBaseUrl => '$_baseUrl/data/2.5';
 static String get geoBaseUrl => '$_baseUrl/geo/1.0';
  static String get getCurrentWeather => '$weatherBaseUrl/weather?';
  static String get getGeoUrl => '$geoBaseUrl/direct?';
  static String get getWeatherByAllDays => '$weatherBaseUrl/forecast?';
}