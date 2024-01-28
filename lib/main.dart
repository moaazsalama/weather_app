import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/routes/module.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/viewmodel/app/app_bloc.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';
//request handler

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
    child: MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => Modular.get<WeatherBloc>(),
        ),
        BlocProvider<AppBloc>(
          create: (context) => Modular.get<AppBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        AppBloc appBloc = BlocProvider.of<AppBloc>(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appBloc.themeMode,
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }
}
