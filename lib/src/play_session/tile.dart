import 'package:flutter/material.dart';
import 'tile_state_enum.dart';

import 'tictactoe_game.dart';

class Tile extends StatefulWidget {
  final Function() onPressed;
  final TileStateEnum tileStateEnum;

  const Tile({Key? key, required this.tileStateEnum, required this.onPressed})
      : super(key: key);

  void tap() {
    if (tileStateEnum == TileStateEnum.empty) {
      TicTacToeGame.currentPlayer = TicTacToeGame.currentPlayer == TileStateEnum.circle
          ? TileStateEnum.cross
          : TileStateEnum.circle;
    }
  }

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tap,
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
          widget.tileStateEnum.value,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
