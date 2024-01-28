extension StringHELP on String {
  //'https://openweathermap.org/img/wn/${state.result.weather.first.icon ?? ''}@4x.png'
  String get weatherIconUrl => "https://openweathermap.org/img/wn/$this@4x.png";
  String get weather2xIconUrl => 'https://openweathermap.org/img/wn/$this@2x.png';
}
