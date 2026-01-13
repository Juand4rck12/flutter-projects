import 'package:flutter/material.dart';

class InfoTitleWidget extends StatelessWidget {
  const InfoTitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
