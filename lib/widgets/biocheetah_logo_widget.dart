import 'package:flutter/material.dart';

class BiocheetahLogoWidget extends StatelessWidget {
  const BiocheetahLogoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/Biocheetah_logo.png',
          height: 100,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'VECanDx Analysis Software',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
