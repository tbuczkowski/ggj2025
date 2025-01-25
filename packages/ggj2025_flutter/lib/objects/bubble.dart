import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Bubble extends SpriteComponent with HasGameReference<GGJ25Game> {

  Bubble({super.position, super.size}) : super(anchor: Anchor.center, priority: 999);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(GfxAssets.bubble));
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  // ignore: must_call_super
  void render(Canvas canvas) {
    Paint opacityPaint = Paint()..color = Colors.white.withOpacity(0.375);
    sprite?.render(
      canvas,
      size: size,
      overridePaint: opacityPaint,
    );
  }
}