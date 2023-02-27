import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String currentPlayer = 'X';
  String winner = '';

  void playAt(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        board[row][col] = currentPlayer;
        if (currentPlayer == 'X') {
          currentPlayer = 'O';
        } else {
          currentPlayer = 'X';
        }
        winner = checkWinner();
      });
    }
  }

  String checkWinner() {
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
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Text(
            'Player: $currentPlayer',
            style: TextStyle(fontSize: 24),
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              int row = (index / 3).floor();
              int col = index % 3;
              return GestureDetector(
                onTap: () => playAt(row, col),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[row][col],
                      style: TextStyle(fontSize: 72),
                    ),
                  ),
                ),
              );
            },
          ),
          if (winner.isNotEmpty)
            Text(
              'Winner: $winner',
              style: TextStyle(fontSize: 24),
            ),
        ],
      ),
    );
  }
}
