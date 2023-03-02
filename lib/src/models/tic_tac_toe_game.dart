import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ticktacktoe/src/game_internals/game_state.dart';

import '../ads/ads_controller.dart';
import '../ads/banner_ad_widget.dart';
import '../audio/audio_controller.dart';
// import '../audio/sounds.dart';
import '../in_app_purchase/in_app_purchase.dart';
import '../play_session/app_localizations.dart';
import '../play_session/tile_state_enum.dart';
import '../style/responsive_screen.dart';

class TicTacToeGame extends StatefulWidget {
  final bool playLocal;
  final ValueChanged<bool> onCelebrationStateChanged;
  final VoidCallback onGameOver;

  const TicTacToeGame({
    Key? key,
    required this.playLocal,
    required this.onCelebrationStateChanged,
    required this.onGameOver,
  }) : super(key: key);

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late AudioController audioController;

  late List<List<TileStateEnum>> board;
  late GameState gameState;

  @override
  void initState() {
    super.initState();
    gameState = GameState(
      onGameOver: widget.onGameOver,
    );
    board = gameState.board;
  }

  @override
  Widget build(BuildContext context) {
    audioController = context.read<AudioController>();
    final adsControllerAvailable = context.watch<AdsController?>() != null;
    final adsRemoved =
        context.watch<InAppPurchaseController?>()?.adRemoval.active ?? false;

    final Map<TileStateEnum, Icon?> tileIcons = {
      TileStateEnum.empty: null,
      TileStateEnum.cross: const Icon(Icons.clear, size: 60.0),
      TileStateEnum.circle: const Icon(Icons.radio_button_unchecked, size: 60.0),
    };

    return Scaffold(
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Text(
              '${AppLocalizations.of(context).translate('player')}:',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30,
                height: 1,
              ),
            ),
            Center(
              child: tileIcons[gameState.currentPlayer],
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
                  itemBuilder: (context, index) {
                    int row = (index / 3).floor();
                    int col = index % 3;
                    return GestureDetector(
                      onTap: () {
                        gameState.playAt(row, col);
                        setState(() {
                          board = gameState.board;
                        });
                      },
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
            if (gameState.getWinner() != TileStateEnum.empty)
              Column(
                children: [
                  Text(
                    '${AppLocalizations.of(context).translate('winner')}:',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30,
                      height: 1,
                    ),
                  ),
                  Icon(
                    tileIcons[gameState.getWinner()]?.icon,
                    size: 60,
                  ),
                ],
              ),
            if (adsControllerAvailable && !adsRemoved)
            const Expanded(
              child: Center(
                child: BannerAdWidget(),
              ),
            ),
          ],
        ),
        rectangularMenuArea: FilledButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: Text(AppLocalizations.of(context).translate('back')),
        ),
      ),
    );
  }
}
