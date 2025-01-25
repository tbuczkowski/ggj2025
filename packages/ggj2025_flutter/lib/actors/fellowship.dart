import 'dart:math';

import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/Combos/ComboHandler.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/bubble.dart';

part 'fellowship_state.dart';

class Fellowship extends PositionComponent with KeyboardHandler, HasGameReference<GGJ25Game> {
  final double extent = 500;

  final FellowshipState state = FellowshipState();
  final ComboHandler inputCombos = ComboHandler();

  late Bubble bubble;

  // late PositionComponent cameraTarget;

  static const double maxMovementSpeed = 25.0;
  double movementSpeed;

  Fellowship({super.position, this.movementSpeed = 0});

  @override
  Future<void> onLoad() async {
    add(bubble = Bubble(position: Vector2(0, 0), size: Vector2.all(0.0)));

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
      movementSpeed = maxMovementSpeed;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      movementSpeed = -maxMovementSpeed;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      movementSpeed = 0.0;
    }

    if(event is KeyDownEvent) {
      inputCombos.comboInput(_comboElement(keysPressed));

    game.parallaxComponent.parallax?.baseVelocity = Vector2(movementSpeed, 0);
    state.currentHero.handleInput(event, keysPressed);
  }

  String _comboElement(Set<LogicalKeyboardKey> keysPressed){
    if(keysPressed.contains(LogicalKeyboardKey.keyQ)) return 'bork';
    if(keysPressed.contains(LogicalKeyboardKey.keyW)) return 'bonk';
    return '';
  }

  @override
  void update(double dt) {
    if (isDead) {
      // TODO: heroes should start begin floating towards the "surface"
      removeFromParent();
    }

    state.currentHero.performAction();

    position.x += dt * movementSpeed;
  }

  bool get isDead => !children.any((e) => e is Bubble);
}
