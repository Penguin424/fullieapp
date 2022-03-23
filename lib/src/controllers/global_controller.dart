// GlobalContollerGetx

import 'package:fullieapp/src/utils/to_tocate.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GloblalController extends GetxController {
  Rx<CameraPosition> cameraPosition = Rx<CameraPosition>(
    const CameraPosition(
      target: LatLng(0, 0),
      zoom: 0,
    ),
  );
  Rx<GoogleMapController>? mapController;
  RxBool isMapReady = false.obs;

  @override
  void onInit() async {
    final currentPosition = await ToLocate.determinePosition();

    cameraPosition.value = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 15,
    );

    isMapReady.value = true;

    super.onInit();
  }
}
