
import 'dart:convert';

class Sys {
    final int? type;
    final int? id;
    final String? country;
    final int? sunrise;
    final int? sunset;

    Sys({
        required this.type,
        required this.id,
        required this.country,
        required this.sunrise,
        required this.sunset,
    });

    factory Sys.fromJson(String str) => Sys.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sys.fromMap(Map<String, dynamic> json) => Sys(
        type: json["type"],
        id: json["id"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };

  @override
  String toString() {
    return 'Sys(type: $type, id: $id, country: $country, sunrise: $sunrise, sunset: $sunset)';
  }
}

