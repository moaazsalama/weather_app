// import '../ios/.symlinks/plugins/connectivity_plus/example/lib/main.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/routes/module.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/viewmodel/app/app_bloc.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';

void main( ) async {
  // print(args);
  WidgetsFlutterBinding.ensureInitialized();
  LocationPermission permission = await Geolocator.checkPermission();

  print(permission.name);
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    await Geolocator.requestPermission();
  }
  runApp(ModularApp(
    module: MyModule(),
    child: DevicePreview(
      enabled: true,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => Modular.get<WeatherBloc>(),
          ),
          BlocProvider<AppBloc>(
            create: (context) => Modular.get<AppBloc>(),
          ),
        ],
        child:  const MyApp(),
      ),
    ),
  ));
}
