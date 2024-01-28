

import 'package:flutter/material.dart';
import 'package:weather_app/core/helper/context_extension.dart';

class WeatherTypeWidget extends StatelessWidget {
  final String title;
  final String image;
  final String value;
  const WeatherTypeWidget({
    super.key,
    required this.title,
    required this.image,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: context.propWidth(24), height: context.propHeight(24)),
        SizedBox(height: context.propHeight(5)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            // height: 0,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            // height: 0,
          ),
        )
      ],
    );
  }
}
