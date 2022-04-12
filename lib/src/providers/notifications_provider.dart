import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/services/notifications_service.dart';

final notificationsPorvider = ChangeNotifierProvider<NotificationsService>(
  (ref) => NotificationsService(),
);
