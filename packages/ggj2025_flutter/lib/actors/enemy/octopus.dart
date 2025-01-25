import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Octopus extends Enemy {
  Octopus({required super.position, super.initialState})
      : super(enemyType: EnemyType.octopus, animationAssets: {
          EnemyState.idle: GfxAssets.octopusIdle,
          EnemyState.walk: GfxAssets.octopusWalk,
          EnemyState.attack: GfxAssets.octopusAttack,
          EnemyState.hurt: GfxAssets.octopusHurt,
          EnemyState.death: GfxAssets.octopusDeath,
        });
}
