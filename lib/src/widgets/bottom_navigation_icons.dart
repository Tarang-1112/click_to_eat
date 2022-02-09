import 'package:flutter/material.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String? name;
  final Function()? onTap;

  // const BottomNavIcon({
  //   Key? key,
  //   required this.image,
  //   required this.name,
  // }) : super(key: key);

  BottomNavIcon({required this.image, this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/$image",
              width: 50,
              height: 35,
            ),
            SizedBox(
              height: 2,
            ),
            CustomText(
                text: name!, size: 16, colors: black, weight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
