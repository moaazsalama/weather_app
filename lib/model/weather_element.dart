import 'dart:convert';

class WeatherElement {
    final int id;
    final String main;
    final String description;
    final String icon;

    WeatherElement({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory WeatherElement.fromJson(String str) => WeatherElement.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WeatherElement.fromMap(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };

  @override
  String toString() {
    return 'WeatherElement(id: $id, main: $main, description: $description, icon: $icon)';
  }
}
