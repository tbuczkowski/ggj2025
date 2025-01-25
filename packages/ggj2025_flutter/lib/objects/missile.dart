import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';

/// Base class for all things that will be tossed by fellowship / enemy bands
class Missile extends SpriteComponent with HasGameReference<GGJ25Game> {
  final int power;
  final String spriteAsset;
  final double speed;

  Missile({
    required this.power,
    required this.speed,
    required this.spriteAsset,
    super.position,
    super.size,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(spriteAsset));

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    if (position.y > game.size.y + size.y) {
      playBreakingEffect();
      return;
    }

    position.y += speed * dt;
  }

  void playBreakingEffect() {
    add(SequenceEffect([
      ColorEffect(Colors.white, EffectController(duration: 0.1), opacityFrom: 0, opacityTo: 1),
      ColorEffect(Colors.white, EffectController(duration: 0.2), opacityFrom: 1, opacityTo: 0),
      ColorEffect(Colors.white, EffectController(duration: 0.1), opacityFrom: 0, opacityTo: 1),
      ColorEffect(Colors.white, EffectController(duration: 0.2), opacityFrom: 1, opacityTo: 0),
      ColorEffect(Colors.white, EffectController(duration: 0.1), opacityFrom: 0, opacityTo: 1)
    ], onComplete: removeFromParent));
  }
}
