import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomFileUploadButton extends StatelessWidget {
  final IconData? icon;
  final Function()? onTap;
  final String? text;
  const CustomFileUploadButton({Key? key, this.icon, this.onTap, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: black)),
            width: 140,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 70,
                    color: grey,
                  ),
                  CustomText(
                    text: text!,
                    size: 14,
                    colors: grey,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
