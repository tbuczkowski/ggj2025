import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Hud extends PositionComponent with HasGameRef<GGJ25Game> {
  late SpriteComponent rhytmIndicator;

  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  @override
  FutureOr<void> onLoad() {
    position = Vector2(50, 50);
    size = Vector2.all(24);
    rhytmIndicator = SpriteComponent(
      sprite: Sprite(game.images.fromCache(GfxAssets.rhytmIndicator)),
      position: Vector2(20, 20),
      size: Vector2.all(24),
      anchor: Anchor.center,
      scale: Vector2(4, 4));
    add(rhytmIndicator);
  }

  @override
  void update(double dt) {
    if(game.combo.gameIsInRhytmWindow){
      rhytmIndicator.add(SequenceEffect([
        ColorEffect(Colors.white, EffectController(duration: 0.05), opacityFrom: 0, opacityTo: 1),
        ColorEffect(Colors.white, EffectController(duration: 0.1), opacityFrom: 1, opacityTo: 0),
      ]));
    }
  }
}