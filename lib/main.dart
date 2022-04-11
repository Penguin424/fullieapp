import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/pages/home_page.dart';
import 'package:fullieapp/src/pages/instituciones/detalle_institucion_page.dart';
import 'package:fullieapp/src/pages/loading_page.dart';
import 'package:fullieapp/src/pages/login_page.dart';
import 'package:fullieapp/src/pages/register_page.dart';
import 'package:fullieapp/src/pages/setting_page.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0XFF1EBCB8),
          onPrimary: Colors.white,
          background: const Color(0XFF42CEA1),
          onBackground: Colors.black,
          secondary: const Color(0XFF4B39EF), //Color(0xFF92f56f)
          onSecondary: Colors.white,
          error: Colors.black,
          onError: Colors.white,
          surface: const Color(0XFF0D1B6B),
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => const LoadingPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/settings': (context) => const SettingsPage(),
        '/register': (context) => const RegisterPage(),
        '/detalle/institucion': (context) => const DetalleInstitucionPage(),
      },
    );
  }
}
