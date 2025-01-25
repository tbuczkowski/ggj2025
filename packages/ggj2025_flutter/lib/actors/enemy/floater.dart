import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Floater extends Enemy {
  Floater({required super.position, super.initialState})
      : super(enemyType: EnemyType.floater, animationAssets: {
          EnemyState.idle: GfxAssets.floaterIdle,
          EnemyState.walk: GfxAssets.floaterWalk,
          EnemyState.attack: GfxAssets.floaterAttack,
          EnemyState.hurt: GfxAssets.floaterHurt,
          EnemyState.death: GfxAssets.floaterDeath,
        });
}
