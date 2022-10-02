import '../models/app_module.dart';
import '../../views/auth/models/auth_user.dart';

class StorageService {
  AuthUser _authUser;

  void saveAuthUser(AuthUser authUser) async {
    _authUser = authUser;
  }

  void removeAuthUser() async {
    _authUser = null;
  }

  AuthUser get authUser => _authUser;

  bool get isAdmin {
    return authUser?.roleName == 'admin' || authUser?.roleName == 'Admin';
  }

  String get accessToken {
    return authUser?.accessToken;
  }

  List<AppModule> get modules {
    return authUser?.modules ?? [];
  }
}
