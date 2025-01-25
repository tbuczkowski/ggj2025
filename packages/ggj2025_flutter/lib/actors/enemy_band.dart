import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/enemy/enemy.dart';
import 'package:ggj2025_flutter/game.dart';

part 'enemy_band_state.dart';

class EnemyBand extends PositionComponent
    with KeyboardHandler, HasGameReference<GGJ25Game> {
  final EnemyBandState state = EnemyBandState();

  EnemyBand({super.position});

  @override
  Future<void> onLoad() async {
    addEnemy(EnemyType.jellyfish);
    addEnemy(EnemyType.octopus);
    addEnemy(EnemyType.eel);
    addEnemy(EnemyType.anglerfish);
    addEnemy(EnemyType.swordfish);

    return super.onLoad();
  }

  void addEnemy(EnemyType enemyType) {
    Enemy enemy = Enemy.enemyFactories[enemyType]!
        .call(Vector2(100.0 * state.enemies.length, 0));
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

bool get isDead => false;
}
