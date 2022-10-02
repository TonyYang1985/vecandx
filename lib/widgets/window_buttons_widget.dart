import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

var buttonColors = WindowButtonColors(
  iconNormal: Color(0xFF805306),
  mouseOver: Color(0xFFF6A00C),
  mouseDown: Color(0xFF805306),
  iconMouseOver: Color(0xFF805306),
  iconMouseDown: Color(0xFFFFD500),
);

var closeButtonColors = WindowButtonColors(
  mouseOver: Colors.red[700],
  mouseDown: Colors.red[900],
  iconNormal: Color(0xFF805306),
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  final bool showConfirmation;
  final Function onShowConfirmationDialog;

  const WindowButtons({
    Key key,
    this.showConfirmation = false,
    this.onShowConfirmationDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        Builder(
          builder: (context) => CloseWindowButton(
            colors: closeButtonColors,
            onPressed: showConfirmation ? () => onShowConfirmationDialog(context) : () => appWindow.close(),
          ),
        ),
      ],
    );
  }
}
