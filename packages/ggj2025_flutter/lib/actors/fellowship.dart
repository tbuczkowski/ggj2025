import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';

part 'fellowship_state.dart';

class Fellowship extends PositionComponent with KeyboardHandler, HasGameReference<GGJ25Game> {
  final FellowshipState state = FellowshipState();

  Fellowship({super.position});

  @override
  Future<void> onLoad() async {
    addHero(HeroType.blue);

    return super.onLoad();
  }

  void addHero(HeroType heroType) {
    Hero hero = Hero.heroFactories[heroType]!.call(Vector2(50.0 * state.heroes.length, 0));
    state.heroes.add(hero);
    add(hero);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    state.currentHero.handleInput(event, keysPressed);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    state.currentHero.performAction();
  }
}
