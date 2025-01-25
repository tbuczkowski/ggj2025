import 'package:flame/components.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/missile.dart';

class Rock extends Missile {
  Rock({super.position})
      : super(
          power: 10.0,
          speed: Vector2(0, 75.0),
          spriteAsset: GfxAssets.rock1,
          size: Vector2.all(24.0),
        );
}
