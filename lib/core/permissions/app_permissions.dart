import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<Map<Permission, PermissionStatus>> requestCoreBankingPermissions() {
    return [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
      Permission.notification,
    ].request();
  }
}
