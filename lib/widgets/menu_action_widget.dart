import 'package:flutter/material.dart';

import '../core/utils/common_util.dart';
import '../core/constants/route_constant.dart';
import '../core/services/navigator_service.dart';
import '../core/locator.dart';
import '../core/services/storage_service.dart';

class MenuActionItem {
  final IconData icon;
  final String title;
  final Function onTap;

  MenuActionItem({@required this.icon, @required this.title, this.onTap});
}

// ignore: must_be_immutable
class MenuActionWidget extends StatelessWidget {
  final storageService = locator<StorageService>();
  final navigatorService = locator<NavigatorService>();
  final BuildContext buildContext;
  final bool showConfirmation;

  var _menuActionItemList = <MenuActionItem>[];

  MenuActionWidget({
    Key key,
    this.buildContext,
    this.showConfirmation = false,
  }) : super(key: key) {
    _menuActionItemList = <MenuActionItem>[
      MenuActionItem(icon: Icons.account_box, title: storageService.authUser?.fullName),
      MenuActionItem(
        icon: Icons.security,
        title: 'Change password',
        onTap: () => _navigateToRoute(Routes.changePassword),
      ),
      MenuActionItem(
        icon: Icons.settings_applications,
        title: 'Profile',
        onTap: () => _navigateToRoute(Routes.updateProfile),
      ),
      MenuActionItem(icon: Icons.logout, title: 'Logout', onTap: _handleLogout),
    ];
  }

  Future<void> _navigateToRoute(String route) async {
    navigatorService.pop();
    navigatorService.navigateToPageNamed(route);
  }

  Future<void> _resetSettings() async {
    storageService.removeAuthUser();
    await navigatorService.navigateToUntilPageWithReplacementNamed(Routes.login);
  }

  void _handleLogout() async {
    if (showConfirmation) {
      await CommonUtil.showConfirmationDialog(
        buildContext,
        confirmationMessage: 'Are you sure you want to logout?',
        onConfirmed: () async => await _resetSettings(),
      );
    } else {
      await _resetSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => _menuActionItemList.map((item) {
        return PopupMenuItem<String>(
          value: item.title,
          child: ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: item.onTap,
          ),
        );
      }).toList(),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Icon(Icons.more_horiz, color: Colors.white, size: 30),
      ),
    );
  }
}
