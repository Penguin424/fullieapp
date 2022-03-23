import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:medirect/src/utils/locationJs.dart' if (dart.library.io) '';
// import 'package:universal_html/js.dart';

class ToLocate {
  // static success(pos) {
  //   try {
  //     print(pos.coords.latitude);
  //     print(pos.coords.longitude);
  //   } catch (ex) {
  //     print("Exception thrown : " + ex.toString());
  //   }
  // }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position? ultima = kIsWeb ? null : await Geolocator.getLastKnownPosition();

    // if (ultima == null) {
    //   // We don't have a position yet, so we need to get one.
    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
    // } else {
    //   // We have a position, so we can return it.
    //   return ultima;
    // }
  }

  // static getCurrentLocation() {
  //   if (kIsWeb) {
  //     getCurrentPosition(allowInterop((pos) => success(pos)));
  //   }
  // }

  static double distance2coord(
    double lat_a,
    double lon_a,
    double lat_b,
    double lon_b,
  ) {
    double res = (acos(
          sin(
                    lat_a * 0.01745329252,
                  ) *
                  sin(
                    lat_b * 0.01745329252,
                  ) +
              (cos(
                    lat_a * 0.01745329252,
                  ) *
                  cos(
                    lat_b * 0.01745329252,
                  ) *
                  cos(
                    lon_a * 0.01745329252 - lon_b * 0.01745329252,
                  )),
        ) *
        57.29577951 *
        111.194);
    return res;
  }
}
