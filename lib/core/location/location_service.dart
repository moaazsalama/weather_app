import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        
        );
    return position;
  }
}
