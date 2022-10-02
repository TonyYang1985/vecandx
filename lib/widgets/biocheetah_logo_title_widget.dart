import 'package:flutter/material.dart';

class BioCheetahLogoTitleWidget extends StatelessWidget {
  final bool alignmentFromLeft;

  const BioCheetahLogoTitleWidget({Key key, this.alignmentFromLeft = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: alignmentFromLeft ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: alignmentFromLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Image.asset(
              'assets/images/Biocheetah_logo.png',
              height: 40,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'VECanDx Analysis Software',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
