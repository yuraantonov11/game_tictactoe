import 'package:flutter/material.dart';
import 'package:ticktacktoe/src/play_session/tile.dart';
import 'package:ticktacktoe/src/play_session/tile_state_enum.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;
  final VoidCallback onPressed;

  TileWidget({super.key, required this.tile, required this.onPressed});

  final Map<TileStateEnum, Icon?> tileIcons = {
    TileStateEnum.empty: null,
    TileStateEnum.cross: const Icon(Icons.clear, size: 60.0),
    TileStateEnum.circle: const Icon(Icons.radio_button_unchecked, size: 60.0),
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tile.tileState == TileStateEnum.empty ? onPressed : null,
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
          // tileIcons(tile.tileState.value),
          '123',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
