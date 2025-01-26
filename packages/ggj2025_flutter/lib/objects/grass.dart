import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

import '../game.dart';

enum GrassType { grass1, grass2, grass3, grass4 }

class Grass extends SpriteComponent with HasGameReference<GGJ25Game> {
  late GrassType grassType;

  Grass({super.position, super.anchor = Anchor.bottomCenter, required this.grassType})
      : super(size: Vector2(32.0, 32.0));

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.images.fromCache(GfxAssets.grassMap[grassType.name]!),
      srcPosition: Vector2.zero(),
      srcSize: switch (grassType) {
        GrassType.grass1 => Vector2(32.0, 32.0),
        GrassType.grass2 => Vector2(38.0, 25.0),
        GrassType.grass3 => Vector2(21.0, 24.0),
        GrassType.grass4 => Vector2(19.0, 23.0),
      },
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    if (game.fellowship.position.x > position.x + 200) {
      position = Vector2(position.x + 1600, position.y);
    }
  }
}
