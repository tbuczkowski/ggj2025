import 'dart:math';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/game.dart';

part 'enemy_band_state.dart';

class EnemyBand extends PositionComponent with HasGameReference<GGJ25Game> {
  final EnemyBandState state = EnemyBandState();
  final List<EnemyType> enemyTypes;

  EnemyBand({super.position, required this.enemyTypes}) : super(anchor: Anchor.center);

  factory EnemyBand.randomBand({
    required Vector2 position,
    required int bandSize,
  }) =>
      EnemyBand(
        enemyTypes: List.generate(
          bandSize,
          (_) => EnemyType.values[Random().nextInt(EnemyType.values.length - 1)],
        ),
        position: position,
      );

  @override
  Future<void> onLoad() async {
    enemyTypes.forEach(addEnemy);

    flipHorizontally();

    return super.onLoad();
  }

  void addEnemy(EnemyType enemyType) {
    Enemy enemy = Enemy.enemyFactories[enemyType]!.call(Vector2(100.0 * state.enemies.length, 0));
    state.enemies.add(enemy);
    add(enemy);
  }

  @override
  void update(double dt) {
    if (isDead) {
      removeFromParent();
    }

    // state.currentHero.performAction();
  }

  bool get isDead => !children.any((c) => c is Enemy);
}
