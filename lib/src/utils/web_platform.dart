import 'package:universal_html/html.dart' as html;

bool detectMovil() {
  final String navigatorPlatform =
      html.window.navigator.platform?.toLowerCase() ?? '';
  if (navigatorPlatform.startsWith('mac')) {
    return true;
  }
  if (navigatorPlatform.startsWith('win')) {
    return true;
  }
  if (navigatorPlatform.contains('iphone') ||
      navigatorPlatform.contains('ipad') ||
      navigatorPlatform.contains('ipod')) {
    return false;
  }
  if (navigatorPlatform.contains('android')) {
    return false;
  }

  if (html.window.matchMedia('only screen and (pointer: fine)').matches) {
    return true;
  }

  return false;
}
