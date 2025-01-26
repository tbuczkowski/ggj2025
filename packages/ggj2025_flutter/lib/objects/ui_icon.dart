import 'package:flame/components.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

sealed class UIIconType {
  static final Vector2 plus = Vector2.zero();
  static final Vector2 minus = Vector2(50, 0);
}

class UIIcon extends SpriteComponent with HasGameReference<GGJ25Game> {
  final Vector2 sourcePosition;

  UIIcon({super.position, required this.sourcePosition}) : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {
    sprite = Sprite(
      game.images.fromCache(GfxAssets.iconsMap),
      srcSize: Vector2.all(50),
      srcPosition: sourcePosition,
    );
  }
}
