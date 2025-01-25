import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/actors/heroes/blue_hero.dart';
import 'package:ggj2025_flutter/actors/heroes/pink_hero.dart';
import 'package:ggj2025_flutter/actors/heroes/white_hero.dart';
import 'package:ggj2025_flutter/game.dart';

enum HeroState { idle, walk, attack1, attack2 }

enum HeroType { blue, white, pink }

abstract class Hero extends SpriteAnimationGroupComponent<HeroState> with HasGameReference<GGJ25Game> {
  final HeroType heroType;
  final HeroState? initialState;
  final Map<HeroState, String> animationAssets;

  factory Hero._blue(Vector2 position) => BlueHero(position: position);
  factory Hero._white(Vector2 position) => WhiteHero(position: position);
  factory Hero._pink(Vector2 position) => PinkHero(position: position);

  static Map<HeroType, Hero Function(Vector2)> heroFactories = {
    HeroType.blue: Hero._blue,
    HeroType.white: Hero._white,
    HeroType.pink: Hero._pink,
  };

  Hero({
    required super.position,
    required this.heroType,
    this.initialState,
    required this.animationAssets,
  }) : super(size: Vector2.all(64), anchor: Anchor.centerLeft);

  @override
  Future<void> onLoad() async {
    loadAnimations();
    add(CircleHitbox());
  }

  loadAnimations() {
    final idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[HeroState.idle]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[HeroState.walk]!),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final attack1Animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[HeroState.attack1]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final attack2Animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationAssets[HeroState.attack2]!),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    animations = {
      HeroState.idle: idleAnimation,
      HeroState.walk: walkAnimation,
      HeroState.attack1: attack1Animation,
      HeroState.attack2: attack2Animation,
    };

    current = initialState ?? HeroState.idle;
  }

  void handleInput(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // react to bongo input - override in concrete implementation
  }

  void performAction() {
    // do sth if correct / known combo was played on bongos - override in concrete implementation
  }
}
