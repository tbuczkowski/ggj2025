import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:ggj2025_flutter/actors/hero.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class GGJ25GameWidget extends StatelessWidget {
  final GGJ25Game game = GGJ25Game();

  GGJ25GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}

class GGJ25Game extends FlameGame {
  @override
  Future<void> onLoad() async {
    await GfxAssets.loadAssets(this);

    add(
      TextComponent(
        position: Vector2(100, 100),
        text: 'Hello, World!',
      ),
    );
    add(Hero(position: Vector2(200, 200), heroType: HeroType.blue));
    add(Hero(position: Vector2(300, 200), heroType: HeroType.white));
    add(Hero(position: Vector2(400, 200), heroType: HeroType.pink));
    await super.onLoad();
  }
}
