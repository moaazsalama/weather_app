import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_app/core/routes/injector.dart';
import 'package:weather_app/core/routes/routes.dart';

class MyModule extends Module {
 
  

  @override
  final List<Bind> binds = injector;

  @override
  final List<ModularRoute> routes = routess;
}
