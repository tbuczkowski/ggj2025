import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class PinkHero extends Hero {
  PinkHero({required super.position, super.initialState})
      : super(
          heroType: HeroType.pink,
          animationAssets: {
            HeroState.idle: GfxAssets.hero3Idle,
            HeroState.walk: GfxAssets.hero3Walk,
            HeroState.attack1: GfxAssets.hero3Attack1,
            HeroState.attack2: GfxAssets.hero3Attack2,
          },
        );
}
