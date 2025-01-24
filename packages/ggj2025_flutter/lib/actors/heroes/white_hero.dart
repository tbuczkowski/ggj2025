import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class WhiteHero extends Hero {
  WhiteHero({required super.position, super.initialState})
      : super(
          heroType: HeroType.white,
          animationAssets: {
            HeroState.idle: GfxAssets.hero2Idle,
            HeroState.walk: GfxAssets.hero2Walk,
            HeroState.attack1: GfxAssets.hero2Attack1,
            HeroState.attack2: GfxAssets.hero2Attack2,
          },
        );
}
