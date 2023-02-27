import 'package:ticktacktoe/src/play_session/tile_state_enum.dart';

class Tile {
  TileStateEnum _tileState;

  Tile({TileStateEnum tileState = TileStateEnum.empty}) : _tileState = tileState;

  TileStateEnum get tileState => _tileState;

  set tileState(TileStateEnum state) {
    _tileState = state;
  }

  void tap(TileStateEnum currentPlayer) {
    if (_tileState == TileStateEnum.empty) {
      _tileState = currentPlayer;
    }
  }
}
