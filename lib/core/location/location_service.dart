import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.high,
        );
    print(position);
    return position;
  }
}
