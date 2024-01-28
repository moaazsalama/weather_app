// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/assets/assets_manger.dart';
import 'package:weather_app/core/helper/constants.dart';
import 'package:weather_app/core/helper/context_extension.dart';
import 'package:weather_app/core/helper/num_extension.dart';
import 'package:weather_app/core/routes/routes_name.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/model/allday.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/view/home/body/widgets/icon_button_custom.dart';
import 'package:weather_app/view/home/body/widgets/screen_wrapper.dart';
import 'package:weather_app/view/home/body/widgets/weather_node_tile.dart';
import 'package:weather_app/view/home/body/widgets/weather_node_type_widget.dart';
import 'package:weather_app/view/home/body/widgets/weather_node_widget.dart';
import 'package:weather_app/viewmodel/bloc/app_bloc.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';

import 'widgets/animated_image.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({
    Key? key,
    required this.isOffline,
  }) : super(key: key);
  final WeatherBloc _weatherBloc = Modular.get<WeatherBloc>();
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return ScreenWrapper(
          isOffline: isOffline,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              // print(state);
              if (state is WeatherError) {
                return Center(
                  child: Text(
                    state.message,
                    style: context.textTheme.labelMedium?.copyWith(
                      // color: Colors.white,
                      fontSize: context.calcilateResponsiveFontSize(14),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      // height: 0.12,
                    ),
                  ),
                );
              } else if (state is WeatherLoading || state is WeatherInitial) {
                return Center(
                  child: SizedBox(
                    width: context.propWidth(100),
                    height: context.propHeight(100),
                    child: CircularProgressIndicator(
                      // color: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.30),
                      // strokeWidth: 5, strokeCap: StrokeCap.round,
                      // value: 0.6,
                    ),
                  ),
                );
              } else if (state is WeatherLoaded) {
                return RefreshIndicator(
                  onRefresh: () {
                    _weatherBloc.add(GetCurrentWeather());
                    return Future.delayed(const Duration(seconds: 2));
                  },
                  notificationPredicate: (notification) => true,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  displacement: 10,
                  strokeWidth: 2,
                  color: Colors.white,
                  semanticsLabel: 'Refresh',
                  child: DataView(
                    weather: state.weather,
                    isOffline: isOffline,
                    day: state.allDay,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }
}

class DataView extends StatelessWidget {
  final bool isOffline;
  final Weather weather;
  final AllDay day;
  final bool isSearch;
  final bool isback;
  const DataView({
    Key? key,
    required this.weather,
    required this.day,
    this.isSearch = true,
    this.isback = false,
    this.isOffline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isback
                  ? IconButtonCustom(
                      onTap: () => Modular.to.pop(),
                      child: const Icon(
                        Icons.close,
                      ),
                    )
                  : IconButtonCustom(
                      child: SvgPicture.asset(
                        AssetManger.catSvg,
                      color: Modular.get<AppBloc>().isDark?Colors.white:Colors.black,
                      ),
                      onTap: () {
                        Modular.get<AppBloc>().add(AppSwithched());
                      },
                    ),
              Text(
                weather.name,
                style: context.textTheme.titleMedium?.copyWith(
                  // color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  // height: 0.07,
                ),
              ),
              isSearch
                  ? IconButtonCustom(
                      onTap: () => Modular.to.pushNamed(AppRoutes.searchView),
                      child: const Icon(
                        Icons.search_sharp,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          if (isOffline)
            Center(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "No Internet Connection",
                  textAlign: TextAlign.center,
                  // style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          context.propHeight(25).toSizedBoxHeightOnly,
          Center(
            child: Text(
              weather.weather.first.main,
              style: context.textTheme.labelMedium?.copyWith(
                // color: const Color(0xFFDEDDDD),
                fontSize: context.calcilateResponsiveFontSize(20),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 0.12,//
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: context.propWidth(172),
              height: context.propHeight(150),
              child: AnimatedImage(
                imagePath: weather.weather.first.icon,
              ),
            ),
          ),
          // SizedBox(height: context.propHeight(20)), ////
          Center(
            child: Text(
              '${weather.main.temp.toCelcius().ceilToDouble().toStringAsFixed(0)}°',
              style: const TextStyle(
                // color: Colors.white,
                fontSize: 60,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                // height: 0.01,
              ),
            ),
          ),
          //
          //time and date of now Friday, 26 August 2022 | 10:00 AM
          Center(
            child: Text(
              DateFormat('EEEE, d MMMM yyyy | hh:mm a').format(DateTime.now()),
              style: context.textTheme.labelMedium?.copyWith(
                // color: Colors.white,
                fontSize: context.calcilateResponsiveFontSize(14),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                // height: 0.12,
              ),
            ),
          ),
          context.propHeight(30).toSizedBoxHeightOnly,
          Center(
            child: Container(
              width: context.propWidth(294),
              height: context.propHeight(100),
              decoration: BoxDecoration(
                gradient: AppColors.mainGrad,
                borderRadius: BorderRadius.circular(Constants.raduis),
              ),
              padding: EdgeInsets.all(Constants.defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WeatherTypeWidget(
                    image: AssetManger.insurance,
                    title: 'Precipitation',
                    value: '${weather.clouds.all}%',
                  ),
                  WeatherTypeWidget(
                    image: AssetManger.humidity,
                    title: 'Humidity',
                    value: '${weather.main.humidity}%',
                  ),
                  WeatherTypeWidget(
                    image: AssetManger.windSpeed,
                    title: 'Wind Speed', //
                    value: '${weather.wind.speed}km/h',
                  ),
                ],
              ),
            ),
          ),
          context.propHeight(30).toSizedBoxHeightOnly,

          //label
          Text(
            'Today',
            style: context.textTheme.labelMedium?.copyWith(
              // color: Colors.white,
              fontSize: context.calcilateResponsiveFontSize(14),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              // height: 0.12,
            ),
          ),
          SizedBox(
            // width: context.propWidth(294),
            height: context.propHeight(100),

            child: ListView.separated(
              scrollDirection: Axis.horizontal, //
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              itemCount: day.todayWeather.length,
              separatorBuilder: (context, index) => context.propWidth(10).toSizedBoxWidthOnly,
              itemBuilder: (context, index) {
                //  day;
                return WeatherNode(day: day.todayWeather[index]);
              },
            ),
          ),
          //tomorrow
          context.propHeight(30).toSizedBoxHeightOnly,
          //label
          Text(
            'Tomorrow',
            style: context.textTheme.labelMedium?.copyWith(
              // color: Colors.white,
              fontSize: context.calcilateResponsiveFontSize(14),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              // height: 0.12,
            ),
          ),
          SizedBox(
            // width: context.propWidth(294),
            height: context.propHeight(100),

            child: ListView.separated(
              scrollDirection: Axis.horizontal, //
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              itemCount: day.tomorrowWeather.length,
              separatorBuilder: (context, index) => SizedBox(width: context.propWidth(10)),
              itemBuilder: (context, index) {
                return WeatherNode(day: day.tomorrowWeather[index]);
              },
            ),
          ),
          //next days
          context.propHeight(30).toSizedBoxHeightOnly,
          //label
          Text(
            'Next Days',
            style: context.textTheme.labelMedium?.copyWith(
              // color: Colors.white,
              fontSize: context.calcilateResponsiveFontSize(14),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              // height: 0.12,
            ),
          ),
          //vertical list view
          ...day.nextDaysWeather
              .map((e) => NodeWidgetTile(
                    weather: e,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
