import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../play_session/app_localizations.dart';
import '../play_session/tile_state_enum.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key, required bool playLocal}) : super(key: key);

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late AudioController audioController;
  List<List<TileStateEnum>> board = List.generate(
      3, (i) => List.filled(3, TileStateEnum.empty));

  TileStateEnum currentPlayer = TileStateEnum.cross;
  TileStateEnum winner = TileStateEnum.empty;

  void playAt(int row, int col) {
    audioController.playSfx(SfxType.buttonTap);
    if (board[row][col] == TileStateEnum.empty) {
      setState(() {
        board[row][col] = currentPlayer;
        if (currentPlayer == TileStateEnum.cross) {
          currentPlayer = TileStateEnum.circle;
        } else {
          currentPlayer = TileStateEnum.cross;
        }
        winner = checkWinner();
      });
    }
  }

  TileStateEnum checkWinner() {
    for (var i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != '') {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != '') {
        return board[0][i];
      }
    }
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != '') {
      return board[0][0];
    }
    if (board[2][0] == board[1][1] && board[1][1] == board[0][2] && board[2][0] != '') {
      return board[2][0];
    }
    return TileStateEnum.empty;
  }

  @override
  Widget build(BuildContext context) {
    audioController = context.read<AudioController>();

    final Map<TileStateEnum, Icon?> tileIcons = {
      TileStateEnum.empty: null,
      TileStateEnum.cross: const Icon(Icons.clear, size: 60.0),
      TileStateEnum.circle: const Icon(Icons.radio_button_unchecked, size: 60.0),
    };

    return Scaffold(
      body: Column(
        children: [
          Text(
            '${AppLocalizations.of(context).translate('player')}:',
            style: TextStyle(fontSize: 24),
          ),
          Center(
            child: tileIcons[currentPlayer],
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                padding: EdgeInsets.all(8.0),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  int row = (index / 3).floor();
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => playAt(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.grey[400]!,
                          ),
                        ),
                        child: Center(
                          child: tileIcons[board[row][col]],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (winner != TileStateEnum.empty)
            Column(
              children: [
                Text(
                  '${AppLocalizations.of(context).translate('winner')}:',
                  style: TextStyle(fontSize: 24),
                ),
                Icon(
                  tileIcons[winner]?.icon,
                  size: 60,
                ),
              ],
            ),
        ],
      ),
    );


  }
}
