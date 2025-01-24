import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:ggj2025_flutter/actors/hero.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';

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
    FlameAudio.bgm.initialize();
    await GfxAssets.loadAssets(this);
    GameAudioPlayer.playBackgroundMusic(SfxAssets.backgroundMusic);

    add(
      TextComponent(
        position: Vector2(100, 100),
        text: 'Hello, World!',
      ),
    );

    add(Hero(
      position: Vector2(200, 200),
      heroType: HeroType.blue,
      initialState: HeroState.walk,
    ));
    add(Hero(
      position: Vector2(300, 200),
      heroType: HeroType.white,
      initialState: HeroState.attack1,
    ));
    add(Hero(
      position: Vector2(400, 200),
      heroType: HeroType.pink,
      initialState: HeroState.attack2,
    ));

    await super.onLoad();
  }
}
