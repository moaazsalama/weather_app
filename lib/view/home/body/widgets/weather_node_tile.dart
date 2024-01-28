
import 'package:flutter/material.dart';
import 'package:weather_app/core/helper/constants.dart';
import 'package:weather_app/core/helper/context_extension.dart';
import 'package:weather_app/core/helper/datetime_extension.dart';
import 'package:weather_app/core/helper/num_extension.dart';
import 'package:weather_app/core/helper/string_extension.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/model/weather.dart';

class NodeWidgetTile extends StatelessWidget {
  final Weather weather;
  const NodeWidgetTile({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: context.propWidth(321),
          height: context.propHeight(100),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.mainGrad,
                  borderRadius: BorderRadius.circular(Constants.raduis),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //day name
                        Text(
                          weather.dateTime.dayName,
                          style: context.textTheme.labelMedium?.copyWith(
                            // color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900, fontStyle: FontStyle.italic,
    
                            // height: 0.12,
                          ),
                        ),
                        Text(
                          weather.weather.first.main,
                          style: context.textTheme.labelMedium?.copyWith(
                            // color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            // height: 0.12,
                          ),
                        ),
                        Text(
                          weather.weather.first.description,
                          style: context.textTheme.labelMedium?.copyWith(
                            // color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            // height: 0.12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: context.propWidth(10)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${weather.dateTime.hourIn12Format} ${weather.dateTime.isAM ? 'PM' : 'AM'}',
                          style: context.textTheme.labelMedium?.copyWith(
                            // color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            // height: 0.12,
                          ),
                        ),
                        Text(
                          '${weather.main.temp.toCelcius().ceilToDouble().toStringAsFixed(0)}°',
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
                  ],
                ),
              ),
              Positioned(
                top: -context.propHeight(10),
                right: -context.propWidth(100),
                // alignment: Alignment.,
                child: SizedBox(
                  height: context.propHeight(100),
                  width: context.propWidth(200),
                  child: Image.network(
                    weather.weather.first.icon.weatherIconUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.network_check),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
