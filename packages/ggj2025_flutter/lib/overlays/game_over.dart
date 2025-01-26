import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';

class GameOver extends StatelessWidget {
  final GGJ25Game game;

  const GameOver({super.key, required this.game});



  @override
  Widget build(BuildContext context) {
    game.bongoButtonsState.redAndGreenOn.addListener(_restartGame);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 500,
          width: 700,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game Over',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 40),
              Text(
                game.scoreComponent.currentScore > game.bestScore
                    ? 'You\'ve beaten the best score!'
                    : 'Best score is: ${game.bestScore}',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: _restartGame,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _restartGame() {
    game.bongoButtonsState.redAndGreenOn.removeListener(_restartGame);

    game.resetWorld();
    game.overlays.remove('GameOver');
  }
}
