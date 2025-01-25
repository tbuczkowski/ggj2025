import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class SirenWarrior extends Enemy {
  SirenWarrior({required super.position, super.initialState})
      : super(enemyType: EnemyType.siren_warrior, animationAssets: {
          EnemyState.idle: GfxAssets.sirenWarriorIdle,
          EnemyState.walk: GfxAssets.sirenWarriorWalk,
          EnemyState.attack: GfxAssets.sirenWarriorAttack,
          EnemyState.hurt: GfxAssets.sirenWarriorHurt,
          EnemyState.death: GfxAssets.sirenWarriorDeath,
        });
}
