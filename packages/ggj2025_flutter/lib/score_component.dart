import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class ScoreComponent extends PositionComponent {

  int currentScore = 0;
  int currentMultiplier = 1;

  late TextComponent _currentScoreTextComponent;
  late TextComponent _currentMultiplierTextComponent;

  ScoreComponent({super.position}) : super(anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    _currentScoreTextComponent = TextComponent(
      text: _scoreText,
      textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          )),
      anchor: Anchor.topLeft,
      position: Vector2.zero(),
    );
    _currentMultiplierTextComponent = TextComponent(
      text: _multiplierText,
      textRenderer: _multiplierStyle,
      anchor: Anchor.topLeft,
      position: Vector2(0, 30),
    );
    addAll([_currentScoreTextComponent, _currentMultiplierTextComponent]);
  }

  @override
  void update(double dt) {
    _currentScoreTextComponent.text = _scoreText;
    _currentMultiplierTextComponent.text = _multiplierText;
    _currentMultiplierTextComponent.textRenderer = _multiplierStyle;
  }

  void addPoints(int points) => currentScore += currentMultiplier * points;

  void increaseMultiplier() => currentMultiplier++;

  void resetMultiplier() => currentMultiplier = 1;

  void reset() {
    currentScore = 0;
    currentMultiplier = 1;
  }

  String get _scoreText => 'Score: ${currentScore}';

  String get _multiplierText => 'x$currentMultiplier';

  TextRenderer get _multiplierStyle {
    Color c = Colors.white;

    if (currentMultiplier > 2) {
      c = Colors.yellow;
    } else if (currentMultiplier > 4) {
      c = Colors.orange;
    } else if (currentMultiplier > 6) {
      c = Colors.red;
    }

    return TextPaint(
        style: TextStyle(
          fontSize: 32,
          color: c,
        ));
  }

}