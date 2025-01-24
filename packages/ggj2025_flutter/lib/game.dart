import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/ground.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/Combos/DoggoComboHandler.dart';

class GGJ25GameWidget extends StatelessWidget {
  final GGJ25Game game = GGJ25Game();

  GGJ25GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}

class GGJ25Game extends FlameGame with KeyboardEvents {
  late final ParallaxComponent parallaxComponent;
  final DoggoComboHandler doggoInputCombos = DoggoComboHandler();

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

    add(Ground(position: Vector2(0, 675)));

    Fellowship fellowship = Fellowship(position: Vector2(100, 625));

    add(fellowship);

    fellowship.addHero(HeroType.white);
    fellowship.addHero(HeroType.pink);

    await super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is KeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      doggoInputCombos.comboInput('bork');
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
