
import 'dart:convert';

class Clouds {
    final int all;

    Clouds({
        required this.all,
    });

    factory Clouds.fromJson(String str) => Clouds.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
        all: json["all"],
    );

    Map<String, dynamic> toMap() => {
        "all": all,
    };

  @override
  String toString() => 'Clouds(all: $all)';
}
