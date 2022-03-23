import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fullieapp/src/models/response_geocoding_busqueda_map_box_model.dart';
import 'package:fullieapp/src/models/response_geocoding_map_box_model.dart';

class Http {
  static final Http _httpMod = Http._internal();
  factory Http() {
    PreferencesUtils.init();

    return _httpMod;
  }
  Http._internal();

  static const String _host = "penguin424.me";

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  static final Map<String, String> _headersAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${PreferencesUtils.getString("jwt")}',
  };

  static Future<Response> get(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      queryParameters: parameters,
      scheme: 'https',
    );

    Response response = await Dio().get(
      url.toString(),
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> loginSocialNetwork(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      queryParameters: parameters,
      scheme: 'https',
    );

    Response response = await Dio().get(
      url.toString(),
    );

    return response;
  }

  static Future<Response> post(
    String path,
    String data,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      scheme: 'https',
    );
    Response response = await Dio().post(
      url.toString(),
      data: data,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> loadImage(Uint8List bytes, XFile result) async {
    Uri url = Uri(
      host: _host,
      path: 'upload',
      scheme: 'https',
    );

    final imageMul = MultipartFile.fromBytes(
      bytes.toList(),
      filename: result.name,
    );

    FormData formData = FormData.fromMap({
      'files': imageMul,
    });

    Response response = await Dio().post(
      url.toString(),
      data: formData,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<String> geocoding(Position coors) async {
    const token =
        'pk.eyJ1IjoiZnVsbGllIiwiYSI6ImNsMDFpZGNzdzByamkzY3BtN2U1ZWdrNWsifQ.kagQe0ytbSLxviwE97_DFw';

    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/${coors.longitude},${coors.latitude}.json?access_token=$token";

    final response = await Dio().get(
      url,
      options: Options(),
    );

    if (response.statusCode == 200) {
      final resCoords =
          ResponseGeocodingMapBoxModel.fromJson(jsonDecode(response.data));

      return resCoords.features!.first!.placeName!;
    } else {
      return "LUGAR NO ECONTRADO";
    }
  }

  static Future<Coordinates> geocodingBusqueda(String busqueda) async {
    const token =
        'pk.eyJ1IjoiZnVsbGllIiwiYSI6ImNsMDFpZGNzdzByamkzY3BtN2U1ZWdrNWsifQ.kagQe0ytbSLxviwE97_DFw';

    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$busqueda.json?access_token=$token"
            .replaceAll("#", "");

    final response = await Dio().get(
      url,
      options: Options(),
    );

    if (response.statusCode == 200) {
      final resCoords = ResponseGeocodingBusquedaMapBoxModel.fromJson(
        jsonDecode(response.data),
      );

      return Coordinates(
        latitude: resCoords.features!.first!.center!.last,
        longitude: resCoords.features!.first!.center!.first,
      );
    } else {
      return Coordinates(latitude: 0.0, longitude: 0.0);
    }
  }

  static Future<Response> login(
    String path,
    String data,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      scheme: 'https',
    );

    Response response = await Dio().post(
      url.toString(),
      data: data,
      options: Options(
        headers: _headers,
      ),
    );

    return response;
  }

  static Future<Response> update(
    String path,
    String data,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      scheme: 'https',
    );
    Response response = await Dio().put(
      url.toString(),
      data: data,
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }

  static Future<Response> delete(
    String path,
    Map<String, dynamic> parameters,
  ) async {
    Uri url = Uri(
      host: _host,
      path: path,
      queryParameters: parameters,
      scheme: 'https',
    );
    Response response = await Dio().delete(
      url.toString(),
      options: Options(
        headers: _headersAuth,
      ),
    );

    return response;
  }
}
