import 'dart:math';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/missile.dart';

class Rock extends Missile {
  Rock({super.position, Vector2? rockSpeed})
      : super(
          power: 10.0,
          speed: rockSpeed ?? Vector2(0, 75.0),
          spriteAsset: GfxAssets.rock1,
          size: Vector2.all(24.0),
        );
}

class Rock2 extends Missile {
  Rock2({super.position, Vector2? rockSpeed})
      : super(
            power: 15.0,
            speed: rockSpeed ?? Vector2(0, 75.0),
            spriteAsset: GfxAssets.rock2,
            size: Vector2.all(32.0),
            flyAnimationData: SpriteAnimationData.sequenced(
              amount: 1,
              stepTime: 1,
              textureSize: Vector2.all(16),
              texturePosition: Vector2.all(0.0),
            ));
}

buildRandomRock({required Random random, required Vector2 position, Vector2? rockSpeed}) {
  return random.nextInt(1024) % 2 == 0
      ? Rock(position: position, rockSpeed: rockSpeed)
      : Rock2(position: position, rockSpeed: rockSpeed);
}
