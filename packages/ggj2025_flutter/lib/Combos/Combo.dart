import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/game.dart';

class Combo {
    List<String> Inputs;
    String Name;
    Function(Fellowship, GGJ25Game) ComboEffect;

    Combo(this.Inputs, this.Name, this.ComboEffect){
    }
}