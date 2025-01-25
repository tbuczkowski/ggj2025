import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/Combos/DoggoComboHandler.dart';
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/camera_target.dart';
import 'package:ggj2025_flutter/config/config_manager.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/ground.dart';
import 'package:ggj2025_flutter/objects/rock.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';

import 'actors/enemy_band.dart';

final GGJ25Game game = GGJ25Game();

class GGJ25GameWidget extends StatelessWidget {
  GGJ25GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}

class GGJ25Game extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  late final ParallaxComponent parallaxComponent;
  final DoggoComboHandler doggoInputCombos = DoggoComboHandler();
  late final ConfigManager configManager;
  late final LevelConfig currentLevelConfig;
  late Fellowship fellowship;
  late CameraTarget _cameraTarget;

  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();
    await GfxAssets.loadAssets(this);
    GameAudioPlayer.playBackgroundMusic(SfxAssets.backgroundMusic);

    configManager = ConfigManager();
    currentLevelConfig = configManager.config.levels[1];

    fellowship = Fellowship(position: Vector2(100, 625));

    List<ParallaxImageData> parallaxDataList = currentLevelConfig.parallax
        .map((parallaxLayer) => ParallaxImageData(parallaxLayer))
        .toList();

    parallaxComponent = await loadParallaxComponent(
      parallaxDataList,
      baseVelocity: Vector2(fellowship.movementSpeed, 0),
      velocityMultiplierDelta: Vector2(1.25, 0),
    );
    add(parallaxComponent);

    world.add(Ground(position: Vector2(0, 675)));
    world.add(fellowship);

    fellowship.addHero(HeroType.white);
    fellowship.addHero(HeroType.pink);

    world.add(Rock(position: Vector2(128, 32)));

    _setupCamera();

    EnemyBand enemyBand = EnemyBand(position: Vector2(300, 300));
    add(enemyBand);

    await super.onLoad();
  }

  void _setupCamera() {
    _cameraTarget = CameraTarget(target: fellowship);
    world.add(_cameraTarget);
    camera.viewfinder.position = fellowship.position;
    camera.follow(_cameraTarget, maxSpeed: 200);
    camera.viewfinder.anchor = Anchor.center;
  }

  double timeSinceLastRockDropped = 0;

  @override
  void update(double dt) {
    if (timeSinceLastRockDropped > 5) {
      world.add(Rock(position: Vector2(128, 32)));
      timeSinceLastRockDropped = 0;
    }

    timeSinceLastRockDropped += dt;

    super.update(dt);
  }

  TextComponent? green;
  TextComponent? red;

  void greenButtonOn() {
    green = TextComponent(
        text: 'Green Button Pressed', position: Vector2(100, 100));
    add(green!);
  }

  void greenButtonOff() {
    remove(green!);
    green = null;
  }

  void redButtonOn() {
    red =
        TextComponent(text: 'Red Button Pressed', position: Vector2(100, 200));
    add(red!);
  }

  void redButtonOff() {
    remove(red!);
    red = null;
  }

  // @override
  // KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //   final isKeyDown = event is KeyDownEvent;
  //
  //   final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
  //
  //   if (isSpace && isKeyDown) {
  //     doggoInputCombos.comboInput('bork');
  //     return KeyEventResult.handled;
  //   }
  //   return KeyEventResult.ignored;
  // }
}
