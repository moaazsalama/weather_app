import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/core/routes/routes_name.dart';
import 'package:weather_app/view/home/home_view.dart';
import 'package:weather_app/view/search/search_view.dart';

List<ModularRoute> get routess {
  return [
    ChildRoute(
      Modular.initialRoute,
      child: (_, __) => const HomeView(),
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 500),
    ),
    ChildRoute(
      AppRoutes.searchView,
      child: (_, __) =>  SearchView(),
      transition: TransitionType.rotate,
      duration: const Duration(milliseconds: 500),
    ),
  ];
}
