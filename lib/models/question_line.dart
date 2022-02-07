import 'package:flutter/material.dart';

class QuestionLine extends StatelessWidget {
  const QuestionLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 5,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
