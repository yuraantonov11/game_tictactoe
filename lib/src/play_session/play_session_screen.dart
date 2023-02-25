import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:game_template/src/level_selection/levels.dart';
import 'package:game_template/src/play_session/tictactoe_game.dart';

class TicTacToeScreen extends StatelessWidget {
  final BluetoothDevice? server;

  const TicTacToeScreen(GameLevel level, {this.server, required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TicTacToeGame(server: server, playLocal: false),
      ),
    );
  }
}
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Tic Tac Toe'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
