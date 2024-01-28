import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/core/helper/constants.dart';
import 'package:weather_app/core/helper/context_extension.dart';
import 'package:weather_app/core/helper/num_extension.dart';
import 'package:weather_app/core/helper/string_extension.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/view/home/body/body.dart';
import 'package:weather_app/view/home/body/widgets/icon_button_custom.dart';
import 'package:weather_app/view/home/body/widgets/screen_wrapper.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final TextEditingController _searchController = TextEditingController();
  bool isSearchNotEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenWrapper(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonCustom(
                    onTap: () {
                      Modular.to.pop();
                    },
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                  Text(
                    'Search for a city',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          // height: 0.12,
                        ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              context.propHeight(20).toSizedBoxHeightOnly,
              Center(
                child: Container(
                  width: context.propWidth(335),
                  height: context.propHeight(50),
                  decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      gradient: AppColors.mainGrad),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      InkWell(
                        child: const Icon(Icons.search, color: Colors.white),
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Modular.get<WeatherBloc>().add(SearchWeather(_searchController.text));
                          //do search
                        },
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatefulBuilder(builder: (context, setstate) {
                          return TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                isSearchNotEmpty = true;
                              } else {
                                isSearchNotEmpty = false;
                              }
                              setstate(() {});
                            },
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  // height: 0.12,
                                ),
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onSubmitted: (value) {
                              FocusScope.of(context).unfocus();
                              Modular.get<WeatherBloc>().add(SearchWeather(value));
                            },
                            decoration: InputDecoration(
                              suffix: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: InkWell(
                                  onTap: () {
                                    _searchController.clear();
                                    FocusScope.of(context).unfocus();
                                    Modular.get<WeatherBloc>().add(SearchWeather(_searchController.text));
                                  },
                                  child: isSearchNotEmpty
                                      ? const Icon(Icons.clear, color: Colors.white)
                                      : const SizedBox(),
                                ),
                              ),
                              hintText: 'Search',
                              hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    // height: 0.12,
                                  ),
                              border: InputBorder.none,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              //search result
              context.propHeight(20).toSizedBoxHeightOnly,
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSearchLoaded) {
                    return InkWell(
                      onTap: () {
                        Modular.to.push(
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                                body: ScreenWrapper(
                              child: DataView(
                                weather: state.result,
                                day: state.resultAllDay,
                                isSearch: false,
                                isback: true,
                              ),
                            )),
                          ),
                        );
                      },
                      child: Container(
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
                                      Text(
                                        state.result.weather.first.main,
                                        style: context.textTheme.labelMedium?.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          // height: 0.12,
                                        ),
                                      ),
                                      Text(
                                        state.result.weather.first.description,
                                        style: context.textTheme.labelMedium?.copyWith(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          // height: 0.12,
                                        ),
                                      ),
                                      //tap to see more
                                      Text(
                                        'Tap to see more',
                                        style: context.textTheme.labelMedium?.copyWith(
                                          color: Colors.white.withOpacity(0.5),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${state.result.main.temp.toCelcius().ceilToDouble().toStringAsFixed(0)}°',
                                        style: context.textTheme.labelMedium?.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
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
                                  state.result.weather.first.icon.weatherIconUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.network_check),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } // return NodeWidgetTile();
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
