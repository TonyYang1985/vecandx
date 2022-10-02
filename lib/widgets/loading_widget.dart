import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final double stroke;
  final Color color;

  const LoadingWidget({
    Key key,
    this.size = 150,
    this.stroke = 10,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: stroke,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
