import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Ground extends SpriteComponent with HasGameReference<GGJ25Game> {
  Ground({super.position, super.anchor = Anchor.bottomLeft}) : super(size: Vector2(32.0, 96.0 - 4));

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.images.fromCache(GfxAssets.tilemap),
      srcPosition: Vector2(368, 80),
      srcSize: Vector2(16.0, 48.0 - 2),
    );
    add(
      SpriteComponent(
        position: Vector2(0.0, 96 - 4),
        size: Vector2(32, 96 - 32 - 4),
        sprite: Sprite(
          game.images.fromCache(GfxAssets.tilemap),
          srcPosition: Vector2(368, 80 + 16 - 2),
          srcSize: Vector2(16.0, 48.0 - 16),
        ),
      ),
    );
    add(
      SpriteComponent(
        position: Vector2(0.0, 92 + 92 - 32),
        size: Vector2(32, 96 - 32 - 4),
        sprite: Sprite(
          game.images.fromCache(GfxAssets.tilemap),
          srcPosition: Vector2(368, 80 + 16 - 2),
          srcSize: Vector2(16.0, 48.0 - 16),
        ),
      ),
    );
    add(
      SpriteComponent(
        position: Vector2(0.0, 92 + 92 + 92 - 64),
        size: Vector2(32, 96 - 32 - 4),
        sprite: Sprite(
          game.images.fromCache(GfxAssets.tilemap),
          srcPosition: Vector2(368, 80 + 16 - 2),
          srcSize: Vector2(16.0, 48.0 - 16),
        ),
      ),
    );

    add(RectangleHitbox(collisionType: CollisionType.inactive));
  }

  @override
  void update(double dt) {
    if (game.fellowship.position.x > position.x + 200) {
      position = Vector2(position.x + 1600, position.y);
    }
  }
}
