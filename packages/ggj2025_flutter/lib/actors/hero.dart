import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

enum HeroState { idle }
enum HeroType { blue, white, pink }

class Hero extends SpriteAnimationGroupComponent<HeroState>
    with HasGameReference<GGJ25Game> {

  final HeroType heroType;

  Hero({required super.position, required this.heroType})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
// _collisionHandler = PlayerCollisionHandler(this, game);
// _animationHandler = PlayerAnimationHandler(this, game);
// _inputHandler = PlayerInputHandler(this);
//
// _animationHandler.loadAnimations();
    _loadAnimations();
    add(CircleHitbox());
  }

  static Map<HeroState, Map<HeroType, String>> animationsMap = {
    HeroState.idle: {
      HeroType.blue: GfxAssets.hero1Idle,
      HeroType.white: GfxAssets.hero2Idle,
      HeroType.pink: GfxAssets.hero3Idle,
    }
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

    animations = {
      HeroState.idle: idleAnimation,
    };

    current = HeroState.idle;
  }
}
