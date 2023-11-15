
import 'package:flutter/material.dart';

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({super.key});

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
            width: width - 44,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "File not found. Try searching again.",
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 20, color: Colors.white),
        )
      ],
    );
  }
}
