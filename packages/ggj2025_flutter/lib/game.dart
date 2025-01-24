import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:ggj2025_flutter/actors/fellowship.dart';
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
  late final ParallaxComponent parallaxComponent;

  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();
    await GfxAssets.loadAssets(this);
    GameAudioPlayer.playBackgroundMusic(SfxAssets.backgroundMusic);

    parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('background/sea_background.png'),
        ParallaxImageData('background/farground.png'),
        ParallaxImageData('background/mid_background.png'),
        ParallaxImageData('background/foreground.png'),
      ],
      baseVelocity: Vector2(0, 0),
    );
    add(parallaxComponent);

    // add(RectangleComponent(
    //   paint: Paint()..color = Colors.yellow,
    //   position: Vector2(0, 660),
    //   size: Vector2(1600, 100),
    // ));

    add(Fellowship(position: Vector2(100, 625)));

    await super.onLoad();
  }
}
