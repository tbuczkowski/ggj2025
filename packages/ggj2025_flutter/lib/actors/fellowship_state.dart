part of 'fellowship.dart';

class FellowshipState {

  final List<Hero> heroes = [];
  int selectedHero = 0;
  double distanceTravelledSinceLastEvent = 0;
  double movementSpeed = 0;

  Hero get currentHero => heroes[selectedHero];

}