import 'package:flutter/material.dart';
import 'package:fullieapp/src/models/institucion_distancia_model.dart';
import 'package:fullieapp/src/models/institucion_model.dart';
import 'package:fullieapp/src/utils/http_utils.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';
import 'package:fullieapp/src/utils/to_tocate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GlobalService extends ChangeNotifier {
  GlobalService() {
    handleGetInitData();
  }

  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 0,
  );
  CameraPosition get cameraPosition => _cameraPosition;
  set cameraPosition(CameraPosition value) {
    _cameraPosition = value;
    notifyListeners();
  }

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  set mapController(GoogleMapController? value) {
    _mapController = value;
    notifyListeners();
  }

  bool _isMapReady = false;
  bool get isMapReady => _isMapReady;
  set isMapReady(bool value) {
    _isMapReady = value;
    notifyListeners();
  }

  bool _isListFocused = false;
  bool get isListFocused => _isListFocused;
  set isListFocused(bool value) {
    _isListFocused = value;
    notifyListeners();
  }

  double _distancia = PreferencesUtils.getInteger('distancia') < 10
      ? 10
      : double.parse(
          PreferencesUtils.getInteger('distancia').toString(),
        );
  double get distancia => _distancia;
  set distancia(double value) {
    _distancia = value;
    PreferencesUtils.putInteger('distancia', value.toInt());
    handleGetInitData();
    notifyListeners();
  }

  List<InstitucionDistanciaModel> _instituciones = [];
  List<InstitucionDistanciaModel> get instituciones => _instituciones;
  set instituciones(List<InstitucionDistanciaModel> value) {
    _instituciones = value;
    notifyListeners();
  }

  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  set markers(Set<Marker> value) {
    _markers = value;
    notifyListeners();
  }

  InstitucionModel _institucionSelected = InstitucionModel();
  InstitucionModel get institucionSelected => _institucionSelected;
  set institucionSelected(InstitucionModel value) {
    _institucionSelected = value;
    notifyListeners();
  }

  bool _isInstitucionSelected = false;
  bool get isInstitucionSelected => _isInstitucionSelected;
  set isInstitucionSelected(bool value) {
    _isInstitucionSelected = value;
    notifyListeners();
  }

  handleGetInitData() async {
    await PreferencesUtils.init();

    final currentPosition = await ToLocate.determinePosition();

    _cameraPosition = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 15,
    );

    final institucionesResponse = await Http.get(
      'instituciones/distancia/${currentPosition.latitude}/${currentPosition.longitude}/$_distancia',
      {},
    );

    final institucionesJsonArray = institucionesResponse.data as List<dynamic>;

    final institucionesDB = institucionesJsonArray.map((institucion) {
      final inst = InstitucionDistanciaModel.fromJson(institucion);
      _markers.add(
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

    _isMapReady = true;
    _instituciones = institucionesDB;

    notifyListeners();
  }

  handleSelectInsitucion(BuildContext context, int id) async {
    try {
      Navigator.pushNamed(context, '/instituciones/detalle');

      final institucionResponse = await Http.get(
        'instituciones/$id',
        {},
      );

      final institucion = InstitucionModel.fromJson(institucionResponse.data);

      _institucionSelected = institucion;
      _isInstitucionSelected = true;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
