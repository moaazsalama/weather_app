class AssetManger {
 static const String _imagePath = "assets/img/";
 static const String _iconPath = "assets/icons/";
 static const String _svgPath = "assets/svg/";
  //assets/img/background.png
// assets/img/cloud-rain-and-lightning.png
// assets/img/cloudy-weather.png
// assets/img/humidity.png
// assets/img/insurance 1.png
// assets/img/rain.png
// assets/img/rainy-weather.png
// assets/img/Wind Speed.png
  //add image path here
 static String get background => "${_imagePath}background.png";
 static String get cloudRainAndLightning => "${_imagePath}cloud-rain-and-lightning.png";
 static String get cloudyWeather => "${_imagePath}cloudy-weather.png";
 static String get humidity => "${_imagePath}humidity.png";
 static String get insurance => "${_imagePath}insurance 1.png";
 static String get rain => "${_imagePath}rain.png";
 static String get rainyWeather => "${_imagePath}rainy-weather.png";
 static String get windSpeed => "${_imagePath}Wind Speed.png";

//   assets/svg/cat.svg
// assets/svg/home.svg
// assets/svg/magnify.svg
  //add svg path here and end variable name with svg
 static String get catSvg => "${_svgPath}cat.svg";
 static String get homeSvg => "${_svgPath}home.svg";
 static String get magnifySvg => "${_svgPath}magnify.svg";
}
