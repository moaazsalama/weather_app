import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/viewmodel/bloc/app_bloc.dart';

class AppColors {
  static const backgroundStart = Color.fromARGB(255, 31, 6, 87);
  static const backgroundMiddle = Color(0xFF331972); //
  static const backgroundEnd = Color(0xFF33143C);
  static LinearGradient get mainGrad {
    AppBloc appBloc = Modular.get<AppBloc>();
    return LinearGradient(
      begin: const Alignment(0.00, -1.00),
      end: const Alignment(0, 1),
      colors: appBloc.isDark == false
          ? [
              Colors.blueAccent,
              const Color.fromARGB(255, 153, 134, 196),
            ]
          : [const Color.fromARGB(255, 153, 134, 196), backgroundStart].reversed.toList(),
    );
  }

  static var backgroundStartLight = Colors.blueAccent;

  static var backgroundMiddleLight = Colors.orangeAccent;

  static var backgroundEndLight = Colors.yellowAccent;
}
