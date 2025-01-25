import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Swordfish extends Enemy {
  Swordfish({required super.position, super.initialState})
      : super(enemyType: EnemyType.swordfish, animationAssets: {
          EnemyState.idle: GfxAssets.swordfishIdle,
          EnemyState.walk: GfxAssets.swordfishWalk,
          EnemyState.attack: GfxAssets.swordfishAttack,
          EnemyState.hurt: GfxAssets.swordfishHurt,
          EnemyState.death: GfxAssets.swordfishDeath,
        });
}
