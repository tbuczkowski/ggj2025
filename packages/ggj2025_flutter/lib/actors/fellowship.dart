import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/bubble.dart';

part 'fellowship_state.dart';

class Fellowship extends PositionComponent with KeyboardHandler, HasGameReference<GGJ25Game> {
  final FellowshipState state = FellowshipState();

  static const double maxMovementSpeed = 25.0;
  double movementSpeed;

  Fellowship({super.position, this.movementSpeed = 0});

  @override
  Future<void> onLoad() async {
    addHero(HeroType.blue);
    add(Bubble(position: Vector2(50, 0), size: Vector2.all(160.0)));

    return super.onLoad();
  }

  void addHero(HeroType heroType) {
    Hero hero = Hero.heroFactories[heroType]!.call(Vector2(50.0 * state.heroes.length, 0));
    state.heroes.add(hero);
    add(hero);
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

    game.parallaxComponent.parallax?.baseVelocity = Vector2(movementSpeed, 0);
    state.currentHero.handleInput(event, keysPressed);

    return super.onKeyEvent(event, keysPressed);
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
