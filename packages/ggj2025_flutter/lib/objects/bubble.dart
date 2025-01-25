import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/missile.dart';

class Bubble extends SpriteComponent with CollisionCallbacks, HasGameReference<GGJ25Game> {
  int _strength = 100;

  Bubble({super.position, super.size}) : super(anchor: Anchor.center, priority: 999);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(GfxAssets.bubble));
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Missile && other.isActive) {
      print('HIT! Strength left: $_strength');
      this._strength -= other.power;
      other.playBreakingEffect();
    }

    super.onCollision(intersectionPoints, other);
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

  @override
  void update(double dt) {
    if (_strength <= 0) {
      removeFromParent(); // TODO: Add blinking effect before bursting / disappearing
    }
  }
}
