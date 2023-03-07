import 'package:flutter/foundation.dart';
import '../play_session/tile_state_enum.dart';

/// Represents the state of a TicTacToe game.
///
/// Tracks the state of the game board, the current player, and calls
/// `onGameOver` when the game is over.
class GameState extends ChangeNotifier {
  final VoidCallback onGameOver;
  late List<List<TileStateEnum>> board;
  int movesPlayed = 0;

  TileStateEnum getWinner() {
    return _checkWinner();
  }

  TileStateEnum _currentPlayer = TileStateEnum.cross;

  GameState({required this.onGameOver}) {
    board = List.generate(
      3,
          (i) => List.filled(3, TileStateEnum.empty),
    );
  }

  TileStateEnum get currentPlayer => _currentPlayer;

  void checkEndGame() {
    movesPlayed++;

    // перевіряємо, чи всі клітинки заповнені
    bool isBoardFull = true;
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == TileStateEnum.empty) {
          isBoardFull = false;
          break;
        }
      }
      if (!isBoardFull) {
        break;
      }
    }

    // якщо всі клітинки заповнені і ніхто не переміг, то гра закінчується в нічию
    if (isBoardFull && getWinner() == TileStateEnum.empty) {
      // закінчуємо гру
      onGameOver();
    }
  }

  void playAt(int row, int col) {
    if (board[row][col] != TileStateEnum.empty) {
      return;
    }

    board[row][col] = currentPlayer;

    if (currentPlayer == TileStateEnum.cross) {
      // audioController.playCrossSound();
      _currentPlayer = TileStateEnum.circle;
    } else {
      // audioController.playCircleSound();
      _currentPlayer = TileStateEnum.cross;
    }

    checkEndGame(); // перевіряємо кінець гри

    notifyListeners();
  }

  void reset() {
    board = List.generate(
      3,
          (i) => List.filled(3, TileStateEnum.empty),
    );
    _currentPlayer = TileStateEnum.cross;
    notifyListeners();
  }

  TileStateEnum _checkWinner() {
    for (var i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != TileStateEnum.empty) {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != TileStateEnum.empty) {
        return board[0][i];
      }
    }
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != TileStateEnum.empty) {
      return board[0][0];
    }
    if (board[2][0] == board[1][1] &&
        board[1][1] == board[0][2] &&
        board[2][0] != TileStateEnum.empty) {
      return board[2][0];
    }
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (board[i][j] == TileStateEnum.empty) {
          // If there is at least one empty cell, the game is not over yet.
          return TileStateEnum.empty;
        }
      }
    }
    // All cells are full, and there is no winner.
    return TileStateEnum.none;
  }
}
