import 'package:flame/components.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/missile.dart';

class IceMissile extends Missile {
  IceMissile({super.position})
      : super(
          power: 20,
          speed: Vector2(100.0, 0),
          spriteAsset: GfxAssets.iceMissileFlying,
          flyAnimationData: SpriteAnimationData.sequenced(
            amount: 10,
            stepTime: 0.25,
            textureSize: Vector2(48, 32),
          ),
          canHurtPlayer: false,
        );
}
