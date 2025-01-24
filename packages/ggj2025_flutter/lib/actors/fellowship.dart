import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/hero.dart';
import 'package:ggj2025_flutter/game.dart';

class Fellowship extends PositionComponent with HasGameReference<GGJ25Game> {
  final List<Hero> heroes = [];

  Fellowship({super.position});

  @override
  Future<void> onLoad() async {
    heroes.addAll([
      Hero(
        position: Vector2(0, 0),
        heroType: HeroType.blue,
        initialState: HeroState.walk,
      ),
      Hero(
        position: Vector2(100, 0),
        heroType: HeroType.white,
        initialState: HeroState.attack1,
      ),
      Hero(
        position: Vector2(200, 0),
        heroType: HeroType.pink,
        initialState: HeroState.attack2,
      ),
    ]);

    addAll(heroes);

    return super.onLoad();
  }
}
