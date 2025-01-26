import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';

class FellowshipHud extends PositionComponent with HasGameReference<GGJ25Game> {

  late TextComponent _bubbleStrengthValue;
  final Vector2 _textOffset = Vector2(60, 20);

  FellowshipHud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  @override
  Future<void> onLoad() async {
    _bubbleStrengthValue = TextComponent(
      text: _bubbleStrengthText,
      textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          )),
      anchor: Anchor.topLeft,
      position: Vector2(20.0, 0),
    );
    add(_bubbleStrengthValue);
  }

  @override
  void update(double dt) {
    _bubbleStrengthValue.text = _bubbleStrengthText;
  }

  String get _bubbleStrengthText => 'o2: ${game.fellowship.bubble.strength}';
}