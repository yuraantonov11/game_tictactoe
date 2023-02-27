import 'package:game_template/src/play_session/tictactoe_game.dart';
import 'package:game_template/src/play_session/tile_state_enum.dart';

class Tile {
  TileStateEnum _tileState;

  Tile({TileStateEnum tileState = TileStateEnum.empty}) : _tileState = tileState;

  TileStateEnum get tileState => _tileState;

  set tileState(TileStateEnum state) {
    _tileState = state;
  }

  void tap() {
    if (_tileState == TileStateEnum.empty) {
      _tileState = TicTacToeGame.currentPlayer;
    }
  }
}

