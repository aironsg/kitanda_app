import 'package:flutter/material.dart';

import '../../config/custom_color.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final int textSize;
  const AppNameWidget({Key? key, this.greenTitleColor, this.textSize = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 30,
        ),
        children: [
          TextSpan(
              text: 'Green',
              style: TextStyle(
                  color: greenTitleColor ?? CustomColor.customSwatchColor,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: 'Grocer',
              style: TextStyle(color: CustomColor.customContrasctColor)),
        ],
      ),
    );
  }
}
