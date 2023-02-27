import 'package:flutter/material.dart';
import 'package:game_template/src/models/tic_tac_toe_game.dart';
import 'package:game_template/src/play_session/tictactoe_game.dart';
import 'package:game_template/src/ui/tile_widget.dart';
import 'package:game_template/tile_widget.dart';
import 'package:provider/provider.dart';


class TicTacToeBoardWidget extends StatelessWidget {
  const TicTacToeBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < 3; i++)
              for (var j = 0; j < 3; j++)
                Text('x')
                // TileWidget(
                //   tile: context.watch<TicTacToeGame>().board[i][j],
                //   onPressed: () =>
                //       context.read<TicTacToeGame>().playAt(i, j),
                // ),
          ],
        ),
      ],
    );
  }
}
