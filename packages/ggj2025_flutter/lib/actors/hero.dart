import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

enum HeroState { idle, walk, attack1, attack2 }

enum HeroType { blue, white, pink }

class Hero extends SpriteAnimationGroupComponent<HeroState>
    with HasGameReference<GGJ25Game> {
  final HeroType heroType;
  final HeroState? initialState;

  Hero({required super.position, required this.heroType, this.initialState})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    _loadAnimations();
    add(CircleHitbox());
  }

  static Map<HeroState, Map<HeroType, String>> animationsMap = {
    HeroState.idle: {
      HeroType.blue: GfxAssets.hero1Idle,
      HeroType.white: GfxAssets.hero2Idle,
      HeroType.pink: GfxAssets.hero3Idle,
    },
    HeroState.walk: {
      HeroType.blue: GfxAssets.hero1IWalk,
      HeroType.white: GfxAssets.hero2Walk,
      HeroType.pink: GfxAssets.hero3Walk,
    },
    HeroState.attack1: {
      HeroType.blue: GfxAssets.hero1IAttack1,
      HeroType.white: GfxAssets.hero2Attack1,
      HeroType.pink: GfxAssets.hero3Attack1,
    },
    HeroState.attack2: {
      HeroType.blue: GfxAssets.hero1IAttack2,
      HeroType.white: GfxAssets.hero2Attack2,
      HeroType.pink: GfxAssets.hero3Attack2,
    },
  };

  _loadAnimations() {
    final idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationsMap[HeroState.idle]![heroType]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationsMap[HeroState.walk]![heroType]!),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final attack1Animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationsMap[HeroState.attack1]![heroType]!),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(32),
        texturePosition: Vector2.all(0.0),
      ),
    );

    final attack2Animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(animationsMap[HeroState.attack2]![heroType]!),
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
}
