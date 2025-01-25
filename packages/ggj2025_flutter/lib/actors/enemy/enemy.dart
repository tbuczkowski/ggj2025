import 'package:ggj2025_flutter/actors/enemy/anglerfish.dart';
import 'package:ggj2025_flutter/actors/enemy/eel.dart';
import 'package:ggj2025_flutter/actors/enemy/jellyfish.dart';
import 'package:ggj2025_flutter/actors/enemy/octopus.dart';
import 'package:ggj2025_flutter/actors/enemy/swordfish.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum EnemyState { idle, walk, attack, hurt, death }

enum EnemyType { jellyfish, swordfish, anglerfish, eel, octopus }

abstract class Enemy extends SpriteAnimationGroupComponent<EnemyState>
    with HasGameReference<GGJ25Game> {
  final EnemyType enemyType;
  final EnemyState? initialState;
  final Map<EnemyState, String> animationAssets;

  factory Enemy.jellyfish(Vector2 position) => Jellyfish(position: position);
  factory Enemy.swordfish(Vector2 position) => Swordfish(position: position);
  factory Enemy.anglerfish(Vector2 position) => Anglerfish(position: position);
  factory Enemy.eel(Vector2 position) => Eel(position: position);
  factory Enemy.octopus(Vector2 position) => Octopus(position: position);

  static Map<EnemyType, Enemy Function(Vector2)> enemyFactories = {
    EnemyType.jellyfish: Enemy.jellyfish,
    EnemyType.swordfish: Enemy.swordfish,
    EnemyType.anglerfish: Enemy.anglerfish,
    EnemyType.eel: Enemy.eel,
    EnemyType.octopus: Enemy.octopus
  };

  Enemy({
    required super.position,
    required this.enemyType,
    this.initialState,
    required this.animationAssets,
  }) : super(size: Vector2.all(96), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    loadAnimations();
    add(CircleHitbox());
  }

  loadAnimations() {
    final idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[EnemyState.idle]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(48),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[EnemyState.walk]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(48),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final attackAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[EnemyState.attack]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(48),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final hurtAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[EnemyState.hurt]!),
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: .2,
        textureSize: Vector2.all(48),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final deathAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[EnemyState.death]!),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .2,
        textureSize: Vector2.all(48),
        texturePosition: Vector2.all(0.0),
      ),
    );

    animations = {
      EnemyState.idle: idleAnimation,
      EnemyState.walk: walkAnimation,
      EnemyState.attack: attackAnimation,
      EnemyState.hurt: hurtAnimation,
      EnemyState.death: deathAnimation,
    };

    current = initialState ?? EnemyState.idle;
  }

  void handleInput(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // react to bongo input - override in concrete implementation
  }

  void performAction() {
    // do sth if correct / known combo was played on bongos - override in concrete implementation
  }
}
