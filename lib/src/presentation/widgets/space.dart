import 'package:flutter/material.dart';

/// A widget to add a Horizontal space in a Row
class HSpace extends StatelessWidget {
  const HSpace(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// A widget to add a Vertical space in a Column
class VSpace extends StatelessWidget {
  const VSpace(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

/// A widget to add a expanded space
class ESpace extends StatelessWidget {
  const ESpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container());
  }
}
