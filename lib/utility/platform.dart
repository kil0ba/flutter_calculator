import 'dart:io' show Platform;

bool isMobile() {
  if (Platform.isAndroid || Platform.isIOS) {
    return true;
  }
  return false;
}
