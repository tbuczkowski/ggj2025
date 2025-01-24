import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Ground extends SpriteComponent with HasGameReference<GGJ25Game> {
  Ground({super.position, super.anchor = Anchor.bottomLeft}) : super(size: Vector2(32.0, 96.0));

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.images.fromCache(GfxAssets.tilemap),
      srcPosition: Vector2(368, 0),
      srcSize: Vector2(16.0, 48.0),
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }
}
