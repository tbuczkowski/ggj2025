import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Eel extends Enemy {
  Eel({required super.position, super.initialState})
      : super(enemyType: EnemyType.eel, animationAssets: {
          EnemyState.idle: GfxAssets.eelIdle,
          EnemyState.walk: GfxAssets.eelWalk,
          EnemyState.attack: GfxAssets.eelAttack,
          EnemyState.hurt: GfxAssets.eelHurt,
          EnemyState.death: GfxAssets.eelDeath,
        });
}
