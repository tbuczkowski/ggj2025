import 'dart:math';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/rock.dart';

part 'enemy_band_state.dart';

class EnemyBand extends PositionComponent with HasGameReference<GGJ25Game> {
  final EnemyBandState state = EnemyBandState();
  final List<EnemyType> enemyTypes;
  final Random random = Random.secure();
  double _timeSinceLastAttack = 0;
  double _nextAttackTime = 0;

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
    Enemy enemy = Enemy.enemyFactories[enemyType]!.call(Vector2(100.0 * state.enemies.length, -10));
    state.enemies.add(enemy);
    add(enemy);
  }

  @override
  void update(double dt) {
    if (isDead) {
      game.insertNextEvent();
      removeFromParent();
    }

    _timeSinceLastAttack += dt;

    if (_timeSinceLastAttack > _nextAttackTime && distanceToFellowship < 750) {
      attack();
      _nextAttackTime = random.nextDouble() % 10 + 10;
      _timeSinceLastAttack = 0;
    }

    // state.currentHero.performAction();
  }

  double get distanceToFellowship => position.distanceTo(game.fellowship.position).abs();

  bool get isDead => !children.any((c) => c is Enemy);

  void attack() {
    int attacks = random.nextInt(state.enemies.length);

    game.world.addAll(List.generate(
        attacks,
        (_) => Rock(
              rockSpeed: Vector2(0, random.nextDouble() * 100 + 25),
              position: Vector2(
                game.fellowship.position.x + random.nextInt(128),
                0,
              ),
            )));
  }
}
