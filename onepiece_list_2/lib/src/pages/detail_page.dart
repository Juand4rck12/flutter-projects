import 'package:flutter/material.dart';
import 'package:onepiece_list_2/src/widgets/blur_container.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.color,
    required this.image,
    required this.title,
  });

  final int color;
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(color), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SizedBox(height: 500.0, child: Image.asset(image)),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child: BlurContainer(
                    child: Container(
                      width: 160.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
