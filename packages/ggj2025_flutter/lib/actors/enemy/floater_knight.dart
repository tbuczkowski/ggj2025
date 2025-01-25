import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class FloaterKnight extends Enemy {
  FloaterKnight({required super.position, super.initialState})
      : super(enemyType: EnemyType.floater_knight, animationAssets: {
          EnemyState.idle: GfxAssets.floaterKnightIdle,
          EnemyState.walk: GfxAssets.floaterKnightWalk,
          EnemyState.attack: GfxAssets.floaterKnightAttack,
          EnemyState.hurt: GfxAssets.floaterKnightHurt,
          EnemyState.death: GfxAssets.floaterKnightDeath,
        });
}
