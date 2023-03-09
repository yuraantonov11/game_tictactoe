import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:ticktacktoe/src/level_selection/levels.dart';
import 'package:ticktacktoe/src/models/tic_tac_toe_game.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/game_state.dart';
import '../games_services/games_services.dart';
import '../games_services/score.dart';
import '../player_progress/player_progress.dart';
import '../style/confetti.dart';
import '../style/palette.dart';
// import '../style/responsive_screen.dart';
// import 'app_localizations.dart';

class PlaySessionScreen extends StatefulWidget {
  // final BluetoothDevice? server;
  final GameLevel level;

  const PlaySessionScreen(this.level, {super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;

  late GameState gameState;

  @override
  void initState() {
    super.initState();
    _startOfPlay = DateTime.now();
  }

  void celebrationStateChange(bool value) {
    setState(() {
      _duringCelebration = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameState(
            onGameOver: _playerWon,
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: Stack(
            children: [
              Center(
                child: TicTacToeGame(
                    onCelebrationStateChanged: celebrationStateChange,
                  playLocal: true,
                  onGameOver: _playerWon,
                )
              ),
              SizedBox.expand(
                child: Visibility(
                  visible: _duringCelebration,
                  child: IgnorePointer(
                    child: Confetti(
                      isStopped: !_duringCelebration,
                    ),
                  ),
                ),
              ),
            ]
          )
        ),
      )
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _playerWon(bool isDraw) async {
    if(isDraw){
      _log.info('Level draw!');
      // await showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       title: Text('Гра закінчилася в нічию'),
      //       content: Text('Нічия!'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: Text('Рестарт'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //             gameState.reset();
      //           },
      //         ),
      //         TextButton(
      //           child: Text('Реклама'),
      //           onPressed: () {
      //             // додати код для показу реклами
      //             // наприклад, викликати метод showAd()
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      GoRouter.of(context).go('/play/draw');
      return;
    }
    _log.info('Level ${widget.level.number} won');

    final score = Score(
      widget.level.number,
      widget.level.difficulty,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.level.number);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.congrats);

    final gamesServicesController = context.read<GamesServicesController?>();
    if (gamesServicesController != null) {
      // Award achievement.
      if (widget.level.awardsAchievement) {
        await gamesServicesController.awardAchievement(
          android: widget.level.achievementIdAndroid!,
          iOS: widget.level.achievementIdIOS!,
        );
      }

      // Send score to leaderboard.
      await gamesServicesController.submitLeaderboardScore(score);
    }

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}
