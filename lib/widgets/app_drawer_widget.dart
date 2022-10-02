import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';
import '../core/services/storage_service.dart';
import '../core/extensions/module_icons_extension.dart';

class AppDrawerWidget extends StatelessWidget {
  final navigatorService = locator<NavigatorService>();
  final storageService = locator<StorageService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('VECanDx Analysis', style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          ...storageService.authUser.modules.map(
            (module) => ListTile(
              title: Text(module.menuName),
              leading: Icon(moduleIconsMap[module.icon]),
              onTap: () => navigatorService.navigateToPageWithReplacementNamed(module.route),
            ),
          ),
        ],
      ),
    );
  }
}
