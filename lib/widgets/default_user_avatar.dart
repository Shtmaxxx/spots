import 'package:flutter/material.dart';

class DefaultUserAvatar extends StatelessWidget {
  const DefaultUserAvatar({
    required this.letter,
    this.size = 50,
    super.key,
  });

  final String letter;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3ecded),
            Color(0xff27b8d9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}