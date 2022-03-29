import 'package:location/location.dart';
import 'package:siminfo/Services/locationService.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.at/maps/dir/15.3830446,44.2112806/14.9622398,44.0225532,10&zoom=14&views=traffic';
    // 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&zoom=14&views=traffic';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openMapURI(String uri) async {
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openMapRouter(double latitude, double longitude) async {
    {
      LocationData? locationData = await LocationService.getLocation();

      String origin =
          '${locationData!.latitude},${locationData.longitude}'; // "somestartLocationStringAddress or lat,long"; // lat,long like 123.34,68.56
      String destination = "$latitude,$longitude,10";
//if (new LocalPlatform().isAndroid) {
      var googleUrl = Uri.encodeFull(
          "https://www.google.com/maps/dir/?api=1&origin=" +
              origin +
              "&destination=" +
              destination +
              "&travelmode=driving&dir_action=navigate"); //

      var googleUrl2 = Uri.encodeFull(
          "https://www.google.com/maps/dir/?api=1&origin=" +
              origin +
              "&destination=" +
              destination +
              "&travelmode=driving&dir_action=navigate");

      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
    /*else {
        String url = "https://www.google.com/maps/dir/?api=1&origin=" + origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate";
        if (await canLaunch(url)) {
              await launch(url);
       } else {
            throw 'Could not launch $url';
       }
    }*/
    ///
    ///
  }
}
