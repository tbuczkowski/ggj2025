import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class BlueHero extends Hero {
  BlueHero({required super.position, super.initialState})
      : super(heroType: HeroType.blue, animationAssets: {
          HeroState.idle: GfxAssets.hero1Idle,
          HeroState.walk: GfxAssets.hero1Walk,
          HeroState.attack1: GfxAssets.hero1Attack1,
          HeroState.attack2: GfxAssets.hero1Attack2,
        });
}
