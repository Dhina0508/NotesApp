import 'package:flutter/material.dart';

class NoNotesFound extends StatelessWidget {
  const NoNotesFound({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/bg.png",
            width: width - 64,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Create your first note !",
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 20, color: Colors.white),
        )
      ],
    );
  }
}
