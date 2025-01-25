import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';

class Combo {
    List<String> Inputs;
    String Name;
    Function(Hero, GGJ25Game) ComboEffect;

    Combo(this.Inputs, this.Name, this.ComboEffect){
    }
}