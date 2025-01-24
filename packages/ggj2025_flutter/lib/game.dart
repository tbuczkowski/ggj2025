import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
    add(
      TextComponent(
        position: Vector2(100, 100),
        text: 'Hello, World!',
      ),
    );
    await super.onLoad();
  }
}
