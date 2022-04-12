import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fullieapp/src/models/data_notification_model.dart';

class NotificationsService extends ChangeNotifier {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initializeAppNotis(
    GlobalKey<NavigatorState> navigation,
    GlobalKey<ScaffoldMessengerState> scaffoldMessenger,
  ) async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        final token = await _messaging.getToken();
        print('token: $token');
        await initializeHanddlers(
          navigation,
          scaffoldMessenger,
        );

        break;

      case AuthorizationStatus.denied:
        break;

      case AuthorizationStatus.notDetermined:
        break;

      case AuthorizationStatus.provisional:
        break;

      default:
        break;
    }
  }

  static initializeHanddlers(
    GlobalKey<NavigatorState> navigation,
    GlobalKey<ScaffoldMessengerState> scaffoldMessenger,
  ) async {
    FirebaseMessaging.onBackgroundMessage(
      _backgroundMessageHandler,
    );
    FirebaseMessaging.onMessage.listen(
      (m) => _onMessageHandler(
        m,
        navigation,
        scaffoldMessenger,
      ),
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (m) => _onMessageOpenAppHandler(
        m,
        navigation,
        scaffoldMessenger,
      ),
    );
  }

  static Future _backgroundMessageHandler(RemoteMessage message) async {
    print('_backgroundMessageHandler: ${message.data}');
  }

  static Future _onMessageHandler(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigation,
    GlobalKey<ScaffoldMessengerState> scaffoldMessenger,
  ) async {
    final dataModel = DataNotificationModel.fromJson(message.data);

    scaffoldMessenger.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message.notification?.body ?? '',
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Abrir',
          onPressed: () {
            navigation.currentState?.pushNamed(
              dataModel.route!,
              arguments: dataModel.arguments,
            );
          },
        ),
      ),
    );
  }

  static Future _onMessageOpenAppHandler(
    RemoteMessage message,
    GlobalKey<NavigatorState> navigation,
    GlobalKey<ScaffoldMessengerState> scaffoldMessenger,
  ) async {
    navigation.currentState?.pushNamed('/detalle/institucion');
  }
}
