// GlobalContollerGetx

import 'package:fullieapp/src/models/institucion_distancia_model.dart';
import 'package:fullieapp/src/utils/http_utils.dart';
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
  RxList<InstitucionDistanciaModel> instituciones =
      <InstitucionDistanciaModel>[].obs;
  RxSet<Marker> markers = <Marker>{}.obs;


  handleGetInitData() async {
    final currentPosition = await ToLocate.determinePosition();

    cameraPosition.value = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 15,
    );

    final institucionesResponse = await Http.get(
      'instituciones/distancia/${currentPosition.latitude}/${currentPosition.longitude}/120',
      {},
    );

    final institucionesJsonArray = institucionesResponse.data as List<dynamic>;

    final institucionesDB = institucionesJsonArray.map((institucion) {
      final inst = InstitucionDistanciaModel.fromJson(institucion);
      markers.add(
        Marker(
          markerId: MarkerId(inst.idInsitucion.toString()),
          position: LatLng(inst.latitud!, inst.longitud!),
          infoWindow: InfoWindow(
            title: inst.institucion,
            snippet: '${inst.direccion}',
          ),
        ),
      );

      return inst;
    }).toList();

    isMapReady.value = true;
    instituciones.value = institucionesDB;
  }
}
