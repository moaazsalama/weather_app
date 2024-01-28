
import 'dart:convert';

class Main {
    final double temp;
    final double feelsLike;
    final double tempMin;
    final double tempMax;
    final int pressure;
    final int humidity;
    final int? seaLevel;
    final int? grndLevel;

    Main({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.humidity,
        required this.seaLevel,
        required this.grndLevel,
    });
    String get tempCelsius => (temp - 273.15).toStringAsFixed(2);
    factory Main.fromJson(String str) => Main.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Main.fromMap(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
    );

    Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
    };

  @override
  String toString() {
    return 'Main(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity, seaLevel: $seaLevel, grndLevel: $grndLevel)';
  }
}
