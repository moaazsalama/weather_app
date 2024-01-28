import 'package:flutter/material.dart';
import 'package:weather_app/core/helper/constants.dart';
import 'package:weather_app/core/helper/context_extension.dart';
import 'package:weather_app/core/helper/datetime_extension.dart';
import 'package:weather_app/core/helper/num_extension.dart';
import 'package:weather_app/core/helper/string_extension.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/model/weather.dart';

class WeatherNode extends StatelessWidget {
  const WeatherNode({
    super.key,
    required this.day,
  });

  final Weather day;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.mainGrad,
        borderRadius: BorderRadius.circular(Constants.raduis),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            '${day.dateTime.hourIn12Format} ${day.dateTime.isAM ? 'PM' : 'AM'}',
            style: context.textTheme.labelMedium?.copyWith(
              // color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              // height: 0.12,
            ),
          ),
          SizedBox(
            height: context.propHeight(30),
            child: Image.network(
              day.weather.first.icon.weather2xIconUrl,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.network_check),
            ),
          ),
          Text(
            '${day.main.temp.toCelcius().ceilToDouble().toStringAsFixed(0)}°',
            style: context.textTheme.labelMedium?.copyWith(
              // color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              // height: 0.12,
            ),
          ),
        ],
      ),
    );
  }
}
