import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import './core/locator.dart';
import './core/providers.dart';
import './core/services/navigator_service.dart';
import './core/constants/route_constant.dart';
import './views/auth/login/login_view.dart';
import './views/auth/reset_password_challenge/reset_password_challenge_view.dart';
import './views/auth/reset_password/reset_password_view.dart';
import './views/auth/create_account/create_account_view.dart';
import './views/home/home_view.dart';
import './views/test/test_add/test_add_view.dart';
import './views/test/test_list/test_list_view.dart';
import './views/test/test_edit/test_edit_view.dart';
import './views/user/user_list/user_list_view.dart';
import './views/role/role_list/role_list_view.dart';
import './views/role/role_add/role_add_view.dart';
import './views/role/role_edit/role_edit_view.dart';
import './views/role_module/role_module_list/role_module_list_view.dart';
import './views/dashboard/dashboard/dashboard_view.dart';
import './views/profile/change_password/change_password_view.dart';
import './views/profile/update_profile/update_profile_view.dart';
import './views/activity_log/role_list/activity_log_list_view.dart';

void main() async {
  await LocatorInjector.setupLocator();
  runApp(MainApplication());

  doWhenWindowReady(() {
    var initialSize = Size(960, 540);
    appWindow.minSize = Size(960, 540);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'VECanDx Analysis';
    appWindow.show();
    appWindow.maximize();
  });
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // showSemanticsDebugger: true,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => HomeView(),
          Routes.dashboard: (context) => DashboardView(),
          Routes.login: (context) => LoginView(),
          Routes.resetPasswordChallenge: (context) => ResetPasswordChallengeView(),
          Routes.resetPassword: (context) => ResetPasswordView(),
          Routes.changePassword: (context) => ChangePasswordView(),
          Routes.updateProfile: (context) => UpdateProfileView(),
          Routes.createAccount: (context) => CreateAccountView(),
          Routes.addTest: (context) => TestAddView(),
          Routes.editTest: (context) => TestEditView(),
          Routes.testList: (context) => TestListView(),
          Routes.addRole: (context) => RoleAddView(),
          Routes.editRole: (context) => RoleEditView(),
          Routes.roleList: (context) => RoleListView(),
          Routes.roleModuleAssignment: (context) => RoleModuleListView(),
          Routes.userList: (context) => UserListView(),
          Routes.activityLog: (context) => ActivityLogListView(),
        },
      ),
    );
  }
}
