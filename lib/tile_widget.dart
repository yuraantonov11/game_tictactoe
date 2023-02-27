import 'package:flutter/material.dart';
import 'package:game_template/src/play_session/tile.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;
  final VoidCallback onPressed;

  const TileWidget({Key? key, required this.tile, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tile.tileState == TileState.empty ? onPressed : null,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          tile.tileState.value,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
