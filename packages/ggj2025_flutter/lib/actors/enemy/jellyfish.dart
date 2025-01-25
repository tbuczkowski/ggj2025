import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Jellyfish extends Enemy {
  Jellyfish({required super.position, super.initialState})
      : super(enemyType: EnemyType.jellyfish, animationAssets: {
          EnemyState.idle: GfxAssets.jellyfishIdle,
          EnemyState.walk: GfxAssets.jellyfishWalk,
          EnemyState.attack: GfxAssets.jellyfishAttack,
          EnemyState.hurt: GfxAssets.jellyfishHurt,
          EnemyState.death: GfxAssets.jellyfishDeath,
        });
}
