import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Calcbutton extends StatelessWidget {
  final Function callback;
  final String text;
  final double textSize;

  const Calcbutton({
    super.key,
    required this.callback,
    required this.text,
    this.textSize = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
      child: SizedBox(
        width: 65.0,
        height: 65.0,
        child: TextButton(
          onPressed: () => {callback(text)},
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: Text(
            text,
            style: GoogleFonts.rubik(textStyle: TextStyle(fontSize: textSize)),
          ),
        ),
      ),
    );
  }
}
