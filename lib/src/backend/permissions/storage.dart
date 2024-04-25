import 'package:permission_handler/permission_handler.dart';

class StoragePermissionService {
  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
    return status.isGranted;
  }

  Future<bool> requestPhotosPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
    return status.isGranted;
  }
}
