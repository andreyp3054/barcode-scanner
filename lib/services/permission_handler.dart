import 'package:permission_handler/permission_handler.dart';

class Handler {
  final permission = Permission.camera;

  Future<void> requestPermission() async {
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  Future<bool> checkPermissionStatus() async {
    return await permission.status.isGranted;
  }

  Future<bool> checkPermanentlyDenied() async {
    return await permission.status.isPermanentlyDenied;
  }

  void openSettings() {
    openAppSettings();
  }
}