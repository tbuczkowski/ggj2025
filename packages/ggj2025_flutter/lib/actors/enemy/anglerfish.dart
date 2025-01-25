import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Anglerfish extends Enemy {
  Anglerfish({required super.position, super.initialState})
      : super(enemyType: EnemyType.anglerfish, animationAssets: {
          EnemyState.idle: GfxAssets.anglerfishIdle,
          EnemyState.walk: GfxAssets.anglerfishWalk,
          EnemyState.attack: GfxAssets.anglerfishAttack,
          EnemyState.hurt: GfxAssets.anglerfishHurt,
          EnemyState.death: GfxAssets.anglerfishDeath,
        });
}
