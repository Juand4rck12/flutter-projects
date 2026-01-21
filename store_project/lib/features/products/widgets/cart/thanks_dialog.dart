import 'package:flutter/material.dart';

class ThanksDialog extends StatelessWidget {
  const ThanksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      elevation: 4.0,
      constraints: BoxConstraints(maxHeight: 150.0, maxWidth: 400.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.verified, size: 60.0, color: Colors.teal),
            Text(
              "¡Gracias por tu compra!",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
