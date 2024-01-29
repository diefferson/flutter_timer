
import 'package:flutter/material.dart';
import 'package:noodle_image/noodle_image.dart';

class OdooCardImage extends StatelessWidget {
  const OdooCardImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(30),
      child: NoodleImage(
        image,
        height: 80,
        width: 80,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
