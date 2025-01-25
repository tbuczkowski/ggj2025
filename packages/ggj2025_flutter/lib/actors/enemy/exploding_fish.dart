import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class ExplodingFish extends Enemy {
  ExplodingFish({required super.position, super.initialState})
      : super(enemyType: EnemyType.exploding_fish, animationAssets: {
          EnemyState.idle: GfxAssets.explodingFishIdle,
          EnemyState.walk: GfxAssets.explodingFishWalk,
          EnemyState.attack: GfxAssets.explodingFishAttack,
          EnemyState.hurt: GfxAssets.explodingFishHurt,
          EnemyState.death: GfxAssets.explodingFishDeath,
        });
}
