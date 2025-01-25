import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

import '../game.dart';

enum GrassType { grass1, grass2, grass3, grass4 }

class Grass extends SpriteComponent with HasGameReference<GGJ25Game> {
  late GrassType grassType;

  Grass({super.position, super.anchor = Anchor.bottomLeft, required this.grassType})
      : super(size: Vector2(32.0, 32.0));

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.images.fromCache(GfxAssets.grassMap[grassType.name]!),
      srcPosition: Vector2.zero(),
      srcSize: Vector2.all(32),
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }
}
