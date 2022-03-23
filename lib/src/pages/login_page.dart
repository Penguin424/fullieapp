import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fullieapp/src/models/login_user_model.dart';
import 'package:fullieapp/src/utils/http_utils.dart';
import 'package:fullieapp/src/utils/preferences_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = true;
  late Timer _timer;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool isHIddenText = true;

  @override
  void initState() {
    _validPreferences();

    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        setState(() {
          _visible = !_visible;
        });
      },
    );
    super.initState();
  }

  Future<void> _validPreferences() async {
    await PreferencesUtils.init();
    bool isLogged = PreferencesUtils.getBool('isLogged');

    if (isLogged) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 2000),
                            child: const Icon(
                              Icons.favorite,
                              size: 128,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'BIENVENIDO A FULLIE',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Inicia sesion',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      // height: size.height * 0.5,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3.0,
                            offset: Offset(
                              0.0,
                              5.0,
                            ),
                            spreadRadius: 3.0,
                          )
                        ],
                      ),
                      child: _createFormLogin(context, size),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _createFormLogin(BuildContext context, Size size) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Ingresa tu correo';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _email = value;
            }),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
              prefixIcon: _email.isNotEmpty
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(
                        12.0,
                      ), // add padding to adjust icon
                      child: Row(
                        children: const [
                          Icon(Icons.person),
                          SizedBox(width: 8),
                          Text(
                            'Correo electrónico',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              return null;
            },
            onChanged: (value) => setState(() {
              _password = value;
            }),
            obscureText: isHIddenText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
              prefixIcon: _password.isNotEmpty
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.lock_outlined),
                              SizedBox(width: 8),
                              Text(
                                'Contraseña',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(isHIddenText
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isHIddenText = !isHIddenText;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
              suffixIcon: _password.isNotEmpty
                  ? IconButton(
                      icon: Icon(isHIddenText
                          ? Icons.remove_red_eye
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isHIddenText = !isHIddenText;
                        });
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          _createRemeberMeForm(context),
          const SizedBox(height: 22),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.3,
                vertical: size.height * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
            ),
            onPressed: _handleSubmit,
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 22),
          _createSingUpSocialMethodsForm(),
          SizedBox(height: size.height * 0.05),
          _createSingUpEmailForm(),
        ],
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final loginResponse = await Http.login(
          'auth/local',
          jsonEncode(
            {
              'identifier': _email,
              'password': _password,
            },
          ),
        );

        if (loginResponse.statusCode == 200) {
          final loginData = LoginUserModel.fromJson(loginResponse.data);

          PreferencesUtils.putBool('isLogged', true);
          PreferencesUtils.putString('jwt', loginData.jwt!);
          PreferencesUtils.putInteger('userId', loginData.user!.id!);
          PreferencesUtils.putString('userName', loginData.user!.nombre!);
          PreferencesUtils.putString(
            'user',
            jsonEncode(
              loginData.user!.toJson(),
            ),
          );

          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Correo o contraseña incorrectos'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Column _createSingUpEmailForm() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '¿No tienes una cuenta?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 200, // <-- Your width
          height: 50, // <-- Your height
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Regístrate',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _createSingUpSocialMethodsForm() {
    return Column(
      children: [
        const Text(
          'O registrate con',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(
                    FontAwesomeIcons.google,
                    size: 22,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Google',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Icon(
                    FontAwesomeIcons.facebookF,
                    size: 22,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Facebook',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _createRemeberMeForm(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              value: true,
              onChanged: (value) {},
            ),
            const Text(
              'Recordarme',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
