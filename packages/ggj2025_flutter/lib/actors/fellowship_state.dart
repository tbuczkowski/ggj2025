part of 'fellowship.dart';

class FellowshipState {

  final List<Hero> heroes = [];
  int selectedHero = 0;

  Hero get currentHero => heroes[selectedHero];

}