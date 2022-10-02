import '../../../core/models/app_module.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';
import '../../../core/services/storage_service.dart';

class DashboardViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();

  bool get isAdmin => _storageService.isAdmin;

  List<AppModule> get modules => _storageService.modules;

  void initialise() {
    notifyListeners();
  }
}
