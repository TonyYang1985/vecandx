import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:vecandx/core/constants/core_data_constant.dart';

import '../core/utils/common_util.dart';
import './window_buttons_widget.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final bool showConfirmation;
  final Function onShowConfirmationDialog;

  const Layout({
    Key key,
    @required this.child,
    this.showConfirmation = false,
    this.onShowConfirmationDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Opacity(
              opacity: 1.0,
              child: WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(
                      child: MoveWindow(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            'VECanDx Analysis (${CoreData.appVersion})',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    WindowButtons(
                      showConfirmation: showConfirmation,
                      onShowConfirmationDialog: onShowConfirmationDialog ?? CommonUtil.showConfirmationDialog,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
