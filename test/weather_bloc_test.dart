import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/location/location_service.dart';
import 'package:weather_app/model/allday.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/weather/weather_service_interface.dart';
import 'package:weather_app/services/weather_cache/weather_cache_service.dart';
import 'package:weather_app/viewmodel/weather/weather_bloc.dart';

class MockWeatherService extends Mock implements WeatherServiceI {}

class MockWeatherCacheService extends Mock implements WeatherCacheService {}

class MockWeatherConnectivtiyService extends Mock implements Connectivity {}

class WeatherMock extends Mock implements Weather {
  @override
  final String name = 'test';
  //to json
  @override
  String toJson() => '{"name":"test"}';
}

class AllDayMock extends Mock implements AllDay {
  final String name = 'test';
  //to json
  @override
  String toJson() => '{"name":"test"}';
}

class MockPostion extends Mock implements Position {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  //arrange
  late WeatherBloc sut;
  late MockWeatherService mockWeatherService;
  late MockWeatherCacheService mockWeatherCacheService;
  late MockWeatherConnectivtiyService mockWeatherConnectivtiyService;
  late Weather weatherMock;
  late AllDayMock allDayMock;
  late MockPostion mockPostion;
  late MockLocationService mockLocationService;

  WidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    mockWeatherService = MockWeatherService();
    mockWeatherCacheService = MockWeatherCacheService();
    mockWeatherConnectivtiyService = MockWeatherConnectivtiyService();
    weatherMock = WeatherMock();
    allDayMock = AllDayMock();
    mockPostion = MockPostion();
    mockLocationService = MockLocationService();
    sut = WeatherBloc(
      weatherServiceInterface: mockWeatherService,
      weatherCacheService: mockWeatherCacheService,
      connectivity: mockWeatherConnectivtiyService,
      geolocator: mockLocationService,
    );
  });
  group('WeatherBloc', () {
    test('Weather intitial State', () {
      expect(sut.state, isA<WeatherInitial>());
      // });
    });
    blocTest<WeatherBloc, WeatherState>(
      'emits [Loading,Error] when GetCurrentWeather is added. get error because of no internet connection and no cache',
      build: () {
        when(() => mockWeatherConnectivtiyService.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);
        when(() => mockWeatherCacheService.getLastCachedWeather()).thenAnswer((_) async => null);
        when(() => mockWeatherCacheService.getLastCachedAllDayWeather()).thenAnswer((_) async => null);
        when(() => mockLocationService.getCurrentLocation()).thenAnswer((_) async => mockPostion);

        return sut;
      },
      act: (bloc) => sut.add(GetCurrentWeather()),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherError>(),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [Loading,Loaded] when GetCurrentWeather is added. get data because of internet connection',
      build: () {
        when(() => mockLocationService.getCurrentLocation()).thenAnswer((_) async => mockPostion);
        when(() => mockWeatherConnectivtiyService.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
        when(() => mockWeatherService.fetchWeatherByPostion(mockPostion)).thenAnswer((_) async => weatherMock);
        when(() => mockWeatherService.fetchWeatherByAllDaysPosition(mockPostion)).thenAnswer((_) async => allDayMock);
        when(() => mockWeatherCacheService.cacheWeather(weatherMock.name, weatherMock.toJson()))
            .thenAnswer((_) async {});
        when(() => mockWeatherCacheService.cacheAllDayWeather(allDayMock.name, allDayMock.toJson()))
            .thenAnswer((_) async {});

        return sut;
      },
      act: (bloc) => sut.add(GetCurrentWeather()),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherLoaded>(),
      ],
    );

    //search
    blocTest<WeatherBloc, WeatherState>(
      'emits [Loading,Loaded] when Search is added. get data because of internet connection',
      build: () {
        when(() => mockLocationService.getCurrentLocation()).thenAnswer((_) async => mockPostion);
        when(() => mockWeatherConnectivtiyService.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
        when(() => mockWeatherService.fetchWeatherByPostion(mockPostion)).thenAnswer((_) async => weatherMock);
        when(() => mockWeatherService.fetchWeatherByAllDaysPosition(mockPostion)).thenAnswer((_) async => allDayMock);
        when(() => mockWeatherCacheService.cacheWeather(weatherMock.name, weatherMock.toJson()))
            .thenAnswer((_) async {});
        when(() => mockWeatherCacheService.cacheAllDayWeather(allDayMock.name, allDayMock.toJson()))
            .thenAnswer((_) async {});
        when(() => mockWeatherService.fetchWeatherByName('test')).thenAnswer((_) async => weatherMock);
        when(() => mockWeatherService.fetchWeatherByAllDays('test')).thenAnswer((_) async => allDayMock);
        sut.emit(WeatherLoaded(weatherMock, allDayMock));
        return sut;
      },
      act: (bloc) {
        // sut.add(GetCurrentWeather());

        bloc.add(SearchWeather('test'));
      },
      // wait: const Duration(milliseconds: 500),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherSearchLoaded>(),
      ],
    );
    //search error
    blocTest<WeatherBloc, WeatherState>(
      'emits [Loading,Error] when Search is added. get error because of no internet connection and no cache',
      build: () {
        when(() => mockLocationService.getCurrentLocation()).thenAnswer((_) async => mockPostion);
        when(() => mockWeatherConnectivtiyService.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
        when(() => mockWeatherService.fetchWeatherByName('test')).thenThrow((_) async => Exception());
        when(() => mockWeatherService.fetchWeatherByAllDays('test')).thenThrow((_) async => Exception());
        when(() => mockWeatherCacheService.cacheWeather(weatherMock.name, weatherMock.toJson()))
            .thenAnswer((_) async {});
        when(() => mockWeatherCacheService.cacheAllDayWeather(allDayMock.name, allDayMock.toJson()))
            .thenAnswer((_) async {});
        //search cache
        when(() => mockWeatherCacheService.getCachedWeather('test')).thenAnswer((_) async => null);
        when(() => mockWeatherCacheService.getCachedAllDayWeather('test')).thenAnswer((_) async => null);
        sut.emit(WeatherLoaded(weatherMock, allDayMock));
        return sut;
      },
      act: (bloc) {
        // sut.add(GetCurrentWeather());

        bloc.add(SearchWeather('test'));
      },
      // wait: const Duration(milliseconds: 500),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherErrorSearch>(),
      ],
    );
    //search cache
    blocTest<WeatherBloc, WeatherState>(
      'emits [Loading,Loaded] when Search is added. get data because of cache and no internet connection',
      build: () {
        when(() => mockLocationService.getCurrentLocation()).thenAnswer((_) async => mockPostion);
        when(() => mockWeatherConnectivtiyService.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
        when(() => mockWeatherService.fetchWeatherByName('test')).thenThrow((_) async => Exception());
        when(() => mockWeatherService.fetchWeatherByAllDays('test')).thenThrow((_) async => Exception());
        when(() => mockWeatherCacheService.cacheWeather(weatherMock.name, weatherMock.toJson()))
            .thenAnswer((_) async {});
        when(() => mockWeatherCacheService.cacheAllDayWeather(allDayMock.name, allDayMock.toJson()))
            .thenAnswer((_) async {});
        //search cache
        when(() => mockWeatherCacheService.getCachedWeather('test')).thenAnswer((_) async => weatherMock);
        when(() => mockWeatherCacheService.getCachedAllDayWeather('test')).thenAnswer((_) async => allDayMock);
        sut.emit(WeatherLoaded(weatherMock, allDayMock));
        return sut;
      },
      act: (bloc) {
        // sut.add(GetCurrentWeather());

        bloc.add(SearchWeather('test'));
      },
      // wait: const Duration(milliseconds: 500),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherSearchLoaded>(),
      ],
    );
  });
}
