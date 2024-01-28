
import 'dart:convert';

class Wind {
    final double speed;
    final int deg;
    final double? gust;

    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    factory Wind.fromJson(String str) => Wind.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Wind.fromMap(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };

  @override
  String toString() => 'Wind(speed: $speed, deg: $deg, gust: $gust)';
}
