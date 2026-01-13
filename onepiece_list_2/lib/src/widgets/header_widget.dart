import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  final titleStyle = const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final subtitleStyle = const TextStyle(fontSize: 16.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(25.0),
      height: 140.0,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 41, 40, 39)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("One Piece", style: titleStyle),
              Text("Serie", style: subtitleStyle),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.black.withValues(alpha: 0.1),
                ),
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.search, size: 28.0, color: Colors.white),
                ),
              ),
              const SizedBox(width: 10.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.black.withValues(alpha: 0.1),
                ),
                child: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.notifications,
                    size: 28.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
