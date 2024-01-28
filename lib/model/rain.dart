
import 'dart:convert';

class Rain {
    final double? the1H;

    Rain({
        required this.the1H,
    });

    factory Rain.fromJson(String str) => Rain.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rain.fromMap(Map<String, dynamic> json) => Rain(
        the1H: json["1h"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "1h": the1H,
    };

  @override
  String toString() => 'Rain(the1H: $the1H)';
}
