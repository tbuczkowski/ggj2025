import 'package:flame/components.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/missile.dart';

class Thunderstrike extends Missile {
  Thunderstrike({required super.position})
      : super(
          power: 50.0,
          speed: Vector2(100.0, 0),
          spriteAsset: GfxAssets.thunderstrike,
          flyAnimationData: SpriteAnimationData.sequenced(
            amount: 13,
            stepTime: 0.25,
            textureSize: Vector2(64, 64),
          ),
          canHurtPlayer: false,
          size: Vector2.all(128.0),
        );
}
