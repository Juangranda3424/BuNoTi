import 'package:flutter/material.dart';

class TextAlert extends StatelessWidget {

  final String text;

  const TextAlert({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center,);
  }
}
