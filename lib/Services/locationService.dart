import 'package:location/location.dart';

class LocationService {
  static Future<LocationData?> getLocation() async {
    var location = new Location();
    LocationData? currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
