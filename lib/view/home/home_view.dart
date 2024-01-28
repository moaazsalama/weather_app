// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/view/home/body/body.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isOffline = false;
  final WeatherBloc _weatherBloc = Modular.get<WeatherBloc>();
  @override
  void initState() {
    _weatherBloc.add(GetCurrentWeather());
    Connectivity().onConnectivityChanged.listen((event) {
      //check internet connection
      if (event == ConnectivityResult.none) {
        Connectivity().checkConnectivity().then((value) {
          if (value == ConnectivityResult.none) {
            setState(() {
              isOffline = true;
            });
          } else {
            setState(() {
              isOffline = false;
            });
          }
        });
      } else {
        setState(() {
          isOffline = false;
        });
      }
      //
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeViewBody(isOffline: isOffline),
    );
  }
}
