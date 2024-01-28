import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;
  AppBloc() : super(AppInitial()) {
    on<AppEvent>((event, emit) {
      if (event is AppSwithched) {
        emit(AppInitial());
        themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
        emit(AppChanged());
      }
    });
  }
}
