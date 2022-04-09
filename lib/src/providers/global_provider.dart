import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/services/global_service.dart';

final globalProvider = ChangeNotifierProvider<GlobalService>(
  (ref) => GlobalService(),
);
