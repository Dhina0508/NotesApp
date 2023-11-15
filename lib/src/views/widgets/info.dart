import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Designed by - Dhinakaran R",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xffCFCFCF)),
        ),
        Text(
          "Redesigned by -",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xffCFCFCF)),
        ),
        Text(
          "Illustrations - From Figma",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xffCFCFCF)),
        ),
        Text(
          "Icons - Material Icons",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xffCFCFCF)),
        ),
        Text(
          "Font - Nunito",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color(0xffCFCFCF)),
        ),
        SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            "Made by Dhinakaran R",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color(0xffCFCFCF)),
          ),
        )
      ],
    );
  }
}
