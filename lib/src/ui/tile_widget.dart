import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final String tile;
  final VoidCallback onPressed;

  const TileWidget({required this.tile, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            tile,
            style: TextStyle(fontSize: 72),
          ),
        ),
      ),
    );
  }
}
