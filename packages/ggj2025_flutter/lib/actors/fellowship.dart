import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/Combos/ComboHandler.dart';
import 'package:ggj2025_flutter/actors/enemy_band.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/bubble.dart';

part 'fellowship_state.dart';

class Fellowship extends PositionComponent with KeyboardHandler, HasGameReference<GGJ25Game> {
  final double extent = 500;

  final FellowshipState state = FellowshipState();
  late ComboHandler combos;

  late Bubble bubble;

  bool actionInProgress = false;

  // late PositionComponent cameraTarget;

  static const double maxMovementSpeed = 180.0;

  Fellowship({super.position}) : super(priority: 2);

  @override
  Future<void> onLoad() async {
    add(bubble = Bubble(position: Vector2(0, 0), size: Vector2.all(0.0)));

    addHero(HeroType.blue);
    combos = game.combo;

    // game.world.add(cameraTarget = PositionComponent(position: Vector2(400, 450)));

    return super.onLoad();
  }

  void addHero(HeroType heroType) {
    Hero hero = Hero.heroFactories[heroType]!.call(Vector2(50.0 * state.heroes.length, 0));
    state.heroes.add(hero);
    add(hero);
    double minX = double.infinity;
    double maxX = 0;
    for (Hero hero in state.heroes) {
      minX = min(minX, hero.position.x);
      maxX = max(maxX, hero.position.x + hero.size.x);
    }
    bubble.size = Vector2(maxX - minX, maxX - minX);
    bubble.position = Vector2(minX + (maxX - minX) / 2, 0);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      startWalking();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      startWalking(-1);
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      stopWalking();
    }

    if (event is KeyDownEvent) {
      combos.comboInput(_comboElement(keysPressed));

      game.parallaxComponent.parallax?.baseVelocity = Vector2(state.movementSpeed, 0);
      state.currentHero.handleInput(event, keysPressed);
    }

    return true;
  }

  String _comboElement(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyQ)) return 'bork';
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) return 'bonk';
    return '';
  }

  @override
  void update(double dt) {
    if (isDead) {
      state.heroes.forEach((h) => h.die());
      if (!children.any((c) => c is Hero)) {
        removeFromParent();
        game.overlays.add('GameOver');
      }

      return;
    }

    if (hasEnemyBandAhead()) {
      stopWalking();
    }

    if (startedWalking != null) {
      startedWalking = startedWalking! + dt;
      if (startedWalking! > 2) {
        startedWalking = null;
        stopWalking();
      }
    }

    double distanceWalked = dt * state.movementSpeed;
    position.x += distanceWalked;
    state.distanceTravelledSinceLastEvent += distanceWalked;
  }

  bool get isDead => !children.any((e) => e is Bubble);

  void stopWalking() {
    actionInProgress = false;
    state.heroes.forEach((hero) => hero.current = HeroState.idle);
    state.movementSpeed = 0;
    updateParallaxVelocity();
  }

  double? startedWalking;

  void startWalking([int direction = 1]) {
    startedWalking = 0;
    actionInProgress = true;
    state.heroes.forEach((hero) => hero.current = HeroState.walk);
    state.movementSpeed = direction * maxMovementSpeed;
    updateParallaxVelocity();
  }

  void attack(HeroType type) {
    actionInProgress = true;
    state.heroes.firstWhere((hero) => hero.heroType == type).attack();
    state.movementSpeed = 0;
    updateParallaxVelocity();
  }

  void finishAttack() {
    actionInProgress = false;
  }

  void updateParallaxVelocity() => game.parallaxComponent.parallax?.baseVelocity = Vector2(state.movementSpeed, 0);

  bool hasEnemyBandAhead() =>
      game.world.children.where((c) => c is EnemyBand && c.position.x - position.x < 300).isNotEmpty;

  void buffDefence() {
    bubble.onBuffDefence();
  }
}
