
import 'package:flutter/material.dart';

class SalonPhoto extends StatelessWidget {
  final String imageUrl;
  final  double size;
  const SalonPhoto({super.key, required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
