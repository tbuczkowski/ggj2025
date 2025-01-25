import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/missile.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';

class Bubble extends SpriteAnimationGroupComponent<bool> with CollisionCallbacks, HasGameReference<GGJ25Game> {
  double _strength = 100;
  CircleHitbox hitbox = CircleHitbox();

  Bubble({super.position, super.size}) : super(anchor: Anchor.center, priority: 999);

  @override
  Future<void> onLoad() async {
    // sprite = Sprite(game.images.fromCache(GfxAssets.bubble));
    add(hitbox);

    final idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(GfxAssets.bubble),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2.all(174),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(GfxAssets.smoke),
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: .3,
        textureSize: Vector2(
          64,
          64,
        ),
        texturePosition: Vector2(0.0, 64 * 8),
        loop: false,
      ),
    );

    animations = {
      true: idleAnimation,
      false: walkAnimation,
    };

    current = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (_strength <= 0) return;
    if (other is Missile && other.isActive && other.canHurtPlayer) {
      print('HIT! Strength left: $_strength');
      this._strength -= other.power;
      other.playBreakingEffect();
      GameAudioPlayer.playEffect([SfxAssets.bounce1, SfxAssets.bounce2, SfxAssets.bounce3][Random().nextInt(3)]);
      add(SequenceEffect([
        ColorEffect(Colors.white, EffectController(duration: 0.1), opacityFrom: 0, opacityTo: 1),
        ColorEffect(Colors.white, EffectController(duration: 0.2), opacityFrom: 1, opacityTo: 0),
      ]));
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  Paint get paint {
    if (current!) {
      return super.paint..color = Colors.white.withOpacity(0.375);
    }
    return super.paint..color = Colors.white.withOpacity(1);
  }

  // @override
  // ignore: must_call_super
  // void render(Canvas canvas) {
  //   Paint opacityPaint = Paint()..color = Colors.white.withOpacity(0.375);
  //   sprite?.render(
  //     canvas,
  //     size: size,
  //     overridePaint: opacityPaint,
  //   );
  // }

  @override
  void update(double dt) {
    super.update(dt);
    if (_strength <= 0 && current!) {
      current = false;
      size = size * 1.8;
      animationTickers![false]!.completed.then((_) {
        removeFromParent();
      });
    }
  }
}
