import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

/// Base class for all things that will be tossed by fellowship / enemy bands
class Missile extends SpriteAnimationGroupComponent<bool> with HasGameReference<GGJ25Game> {
  final double power;
  final String spriteAsset;
  final Vector2 speed;
  final bool canHurtPlayer;
  final SpriteAnimationData? flyAnimationData;

  final double? lifetime;

  late double currentPower;

  bool isActive = true;

  Missile({
    required this.power,
    required this.speed,
    required this.spriteAsset,
    this.canHurtPlayer = true,
    this.flyAnimationData,
    super.position,
    super.size,
    this.lifetime = double.infinity,
  }) : super(anchor: Anchor.center);

  void onHit() {}

  @override
  Future<void> onLoad() async {
    // sprite = Sprite(game.images.fromCache(spriteAsset));

    currentPower = power;

    final idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(spriteAsset),
      flyAnimationData ??
          SpriteAnimationData.sequenced(
            amount: 1,
            stepTime: 1,
            textureSize: Vector2.all(8),
            texturePosition: Vector2.all(0.0),
          ),
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(GfxAssets.smoke),
      SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: .2,
          textureSize: Vector2(
            64,
            64,
          ),
          texturePosition: Vector2(0.0, 64 * 5),
          loop: false),
    );

    animations = {
      true: idleAnimation,
      false: walkAnimation,
    };

    current = isActive;

    add(RectangleHitbox());
  }

  double time = 0;

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    if (position.y > game.size.y + size.y || currentPower <= 0 || time > lifetime!) {
      playBreakingEffect();
      return;
    }
    if (isActive) {
      position.y += speed.y * dt;
      position.x += speed.x * dt;
    }
  }

  void playBreakingEffect() {
    isActive = false;
    current = isActive;
    onHit.call();
    size = size * 3;
    add(SequenceEffect([
      ColorEffect(Colors.white, EffectController(duration: 1.2), opacityFrom: 0, opacityTo: 1),
    ], onComplete: removeFromParent));
  }

  void reducePower(double value) {
    currentPower -= value;
  }
}
