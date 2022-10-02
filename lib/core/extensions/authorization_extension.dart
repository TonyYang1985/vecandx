import '../models/app_module.dart';
import '../models/permission.dart';
import '../services/storage_service.dart';
import '../locator.dart';

extension ModuleAuthorization on String {
  static final storageService = locator<StorageService>();

  bool get isAuthorized {
    return storageService.modules.any((module) => module.moduleName == this);
  }
}

extension ModuleNamePermissionAuthorization on Permission {
  static final storageService = locator<StorageService>();

  bool allowedIn(String moduleName) {
    final module = storageService.modules.firstWhere(
      (module) => module.moduleName == moduleName,
      orElse: () => null,
    );

    if (module == null) return false;

    return module.permissions.any((permissionType) => permissionType == this);
  }
}

extension ModulePermissionAuthorization on Permission {
  static final storageService = locator<StorageService>();

  bool allowedInModule(AppModule module) {
    if (module == null) return false;

    return module.permissions.any((permissionType) => permissionType == this);
  }
}
