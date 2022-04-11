import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fullieapp/src/models/direccion_model.dart';
import 'package:fullieapp/src/models/user_social_network.dart';
import 'package:fullieapp/src/utils/http_utils.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';
import 'package:geocode/geocode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterService extends ChangeNotifier {
  // controllers de los formularios

  final _formDatosUsuario = GlobalKey<FormState>();
  get formDatosUsuario => _formDatosUsuario;
  final _formDatosDireccion = GlobalKey<FormState>();
  get formDatosDireccion => _formDatosDireccion;

  // variables de control de vista
  bool _isImageChange = false;
  bool get isImageChange => _isImageChange;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Datos de usuario

  final _pageController = PageController(
    initialPage: 0,
  );
  get pageController => _pageController;

  String _nombre = '';
  String get nombre => _nombre;
  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String _passwordConfirm = '';
  String get passwordConfirm => _passwordConfirm;
  set passwordConfirm(String value) {
    _passwordConfirm = value;
    notifyListeners();
  }

  String _telefono = '';
  String get telefono => _telefono;
  set telefono(String value) {
    _telefono = value;
    notifyListeners();
  }

  // DATOS DE DIRECCION
  String _direccion = '';
  String get direccion => _direccion;
  set direccion(String value) {
    _direccion = value;
    notifyListeners();
  }

  String _colonia = '';
  String get colonia => _colonia;
  set colonia(String value) {
    _colonia = value;
    notifyListeners();
  }

  String _codigoPostal = '';
  String get codigoPostal => _codigoPostal;
  set codigoPostal(String value) {
    _codigoPostal = value;
    notifyListeners();
  }

  String _ciudad = '';
  String get ciudad => _ciudad;
  set ciudad(String value) {
    _ciudad = value;
    notifyListeners();
  }

  String _estado = '';
  String get estado => _estado;
  set estado(String value) {
    _estado = value;
    notifyListeners();
  }

  // DATOS DE PERFIL
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imagenPerfil;
  XFile? get imagenPerfil => _imagenPerfil;
  Uint8List _imagenPerfilBytes = Uint8List(0);
  Uint8List get imagenPerfilBytes => _imagenPerfilBytes;

  handleChangeToDatosDireccion() {
    if (_formDatosUsuario.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  handleChangeToDatosPerfil() {
    if (_formDatosDireccion.currentState!.validate()) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  handleUpdateImageFromGallery() async {
    final permiso = await Permission.photos.request();

    if (permiso.isGranted) {
      XFile? imagen = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (imagen != null) {
        _imagenPerfil = imagen;
        _imagenPerfilBytes = await imagen.readAsBytes();
        _isImageChange = true;

        notifyListeners();
      }
    } else {}

    notifyListeners();
  }

  handleUpdateImageFromCamera() async {
    final permiso = await Permission.camera.request();

    if (permiso.isGranted) {
      XFile? imagen = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      if (imagen != null) {
        _imagenPerfil = imagen;
        _imagenPerfilBytes = await imagen.readAsBytes();
        _isImageChange = true;

        notifyListeners();
      }
    } else {}

    notifyListeners();
  }

  handleSubmitRegister(BuildContext context) async {
    try {
      await PreferencesUtils.init();

      _isLoading = true;

      notifyListeners();
      final registerUser = await Http.login(
        'auth/local/register',
        jsonEncode(
          {
            'username': _email.split('@')[0],
            'email': _email,
            'password': _password,
          },
        ),
      );

      final user = UserSocialNet.fromMap(registerUser.data);

      PreferencesUtils.putString(
        'jwt',
        user.jwt,
      );

      Coordinates coords = await Http.geocodingBusqueda(
        '$_direccion $_colonia $_ciudad $_estado $_codigoPostal',
      );

      final direccionDB = await Http.post(
        'usuariodirecciones',
        jsonEncode(
          {
            "direccion": _direccion,
            "ciudad": _ciudad,
            "codigoPostal": _codigoPostal,
            "estado": _estado,
            "latitud": coords.latitude,
            "longitud": coords.longitude,
            "colonia": _colonia,
            "cruces": '',
            "referencia": '',
          },
        ),
      );

      int imagenId = 12;
      Direccion direccionCreate = Direccion.fromMap(
        direccionDB.data,
      );

      if (_isImageChange) {
        final imagenResponse = await Http.loadImage(
          _imagenPerfilBytes,
          imagenPerfil!,
        );

        if (imagenResponse.statusCode == 200) {
          imagenId = imagenResponse.data[0]['id'];
        }

        await Http.update(
          "users/${user.user.id}",
          jsonEncode({
            'usuariodireccion': direccionCreate.id,
            'role': 3,
            'imagen': _isImageChange ? imagenId : 12,
            'telefono': _telefono,
            'nombre': _nombre,
          }),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Resgistro exitoso, inicia sesión',
            ),
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (Route<dynamic> route) => false,
        );

        _isLoading = false;

        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
