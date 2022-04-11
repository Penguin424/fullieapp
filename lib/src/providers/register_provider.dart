import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullieapp/src/services/register_servise.dart';

final registerProvider = ChangeNotifierProvider<RegisterService>(
  (ref) => RegisterService(),
);
