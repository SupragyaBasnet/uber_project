import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String assetPath;
  final double height;

  const Logo._({super.key, required this.assetPath, this.height = 80.0});

  // Colour Logo
  const Logo.colour({Key? key, double height = 80.0})
      : this._(key: key, assetPath: 'assets/icons/logo.png', height: height);

  // White Logo
  const Logo.white({Key? key, double height = 80.0})
      : this._(key: key, assetPath: 'assets/icons/logo.png', height: height);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        assetPath,
        height: height,
      ),
    );
  }
}
