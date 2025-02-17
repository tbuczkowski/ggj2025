import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Hero;
import 'package:ggj2025_flutter/Combos/ComboHandler.dart';
import 'package:ggj2025_flutter/Hud.dart';
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/bongo_time.dart';
import 'package:ggj2025_flutter/camera_target.dart';
import 'package:ggj2025_flutter/config/config_manager.dart';
import 'package:ggj2025_flutter/event_generator.dart';
import 'package:ggj2025_flutter/fellowship_hud.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/ground.dart';
import 'package:ggj2025_flutter/overlays/game_over.dart';
import 'package:ggj2025_flutter/score_component.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';

import 'objects/grass.dart';

final GGJ25Game game = GGJ25Game();

class GGJ25GameWidget extends StatelessWidget {
  GGJ25GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (focus, onKey) => KeyEventResult.handled,
      child: GameWidget<GGJ25Game>(game: game, overlayBuilderMap: {
        'GameOver': (_, game) => GameOver(game: game),
      },),
    );
  }
}

class GGJ25Game extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  late final ParallaxComponent parallaxComponent;
  late final ConfigManager configManager;
  late final LevelConfig currentLevelConfig;
  late CameraTarget _cameraTarget;
  final EventGenerator _eventGenerator = EventGenerator();
  late ScoreComponent scoreComponent;
  late Fellowship _fellowship;
  late BongoTime bonusBongo = BongoTime();

  int bestScore = 0;

  CameraTarget get cameraTarget => _cameraTarget;
  late final ComboHandler combo = ComboHandler();

  Fellowship get fellowship => _fellowship;

  @override
  bool get debugMode => false;

  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();
    await GfxAssets.loadAssets(this);
    GameAudioPlayer.playBackgroundMusic(SfxAssets.backgroundMusic);

    configManager = ConfigManager();
    currentLevelConfig = configManager.config.levels[1];

    List<ParallaxImageData> parallaxDataList = currentLevelConfig.parallax
        .map((parallaxLayer) => ParallaxImageData(parallaxLayer))
        .toList();

    parallaxComponent = await loadParallaxComponent(
      parallaxDataList,
      baseVelocity: Vector2(0, 0),
      velocityMultiplierDelta: Vector2(1.01, 0),
    );

    add(parallaxComponent);
    add(combo);

    _loadWorld();

    await super.onLoad();
  }

  void _loadWorld() {
    _fellowship = Fellowship(
      position: Vector2(
        0,
        camera.viewport.size.y * 0.90 - 122,
      ),
    );

    world.add(fellowship);

    fellowship.addHero(HeroType.white);
    fellowship.addHero(HeroType.pink);

    for (int i = -20; i < 80; i++) {
      world.add(Ground(
          position: Vector2(
            16.0 * i,
            camera.viewport.size.y * 0.90,
          )));

      if (i % 4 == 0)
        world.add(
          Grass(
            position: Vector2(16.0 * i, camera.viewport.size.y * 0.90 - 90),
            grassType: GrassType.values.random(),
          ),
        );
    }

    _setupCamera();

    insertNextEvent();
  }

  void _setupCamera() {
    scoreComponent = ScoreComponent(position: Vector2(20, 40));
    _cameraTarget = CameraTarget(target: fellowship, position: Vector2(300, 0));
    world.add(_cameraTarget);
    camera.viewfinder.position = fellowship.position;
    camera.follow(_cameraTarget, maxSpeed: 200, snap: true);
    camera.viewfinder.anchor = Anchor(0.1, 0.5);
    camera.viewport.add(Hud());
    camera.viewport.add(FellowshipHud());
    camera.viewport.add(scoreComponent);
    camera.viewport.add(bonusBongo);
  }

  double timeSinceLastRockDropped = 0;

  @override
  void update(double dt) {
    _eventGenerator.updateTimeSinceLastEvent(dt);
    _eventGenerator.addRandomRockAppearsEvent(world);

    super.update(dt);
  }

  void insertNextEvent() {
    _eventGenerator.addEventToScene(world, fellowship);
  }

  TextComponent? green;
  TextComponent? red;

  void greenButtonOn() {
    // green = TextComponent(text: 'Green Button Pressed', position: Vector2(100, 100));
    combo.comboInput('bork');
    bongoButtonsState.greenOn = true;
    // add(green!);
  }

  void greenButtonOff() {
    // remove(green!);
    // green = null;
    bongoButtonsState.greenOn = false;
  }

  void redButtonOn() {
    // red = TextComponent(text: 'Red Button Pressed', position: Vector2(100, 200));
    combo.comboInput('bonk');
    bongoButtonsState.redOn = true;
    // add(red!);
  }

  void redButtonOff() {
    // remove(red!);
    // red = null;
    bongoButtonsState.redOn = false;
  }

  BongoButtonsState bongoButtonsState = BongoButtonsState();

  void resetWorld() {
    if (scoreComponent.currentScore > bestScore) {
      bestScore = scoreComponent.currentScore;
    }

    game.world = World();
    camera.viewport = MaxViewport();
    _loadWorld();
  }
}

class BongoButtonsState {
  bool _red = false;
  bool _green = false;

  set redOn(val) {
    _red = val;
    redAndGreenOn.value = _red && _green;
  }

  set greenOn(val) {
    _green = val;
    redAndGreenOn.value = _red && _green;
  }

  ValueNotifier<bool> redAndGreenOn = ValueNotifier(false);
}
