import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/missiles/ice_missile.dart';
import 'package:ggj2025_flutter/objects/missiles/thunderstrike.dart';

class Combo {
  final List<String> inputs;
  final String name;
  final Function(GGJ25Game) comboEffect;

  const Combo(this.inputs, this.name, this.comboEffect);

  @override
  bool operator ==(Object other) {
    if (other is Combo) return other.name == name;
    return false;
  }
}

sealed class Combos {
  static final Combo tripleBork = Combo(["bonk", "bonk", "bork", "bork"], "bork overdrive", (game) {
    game.world.add(IceMissile(position: game.fellowship.position));
    game.fellowship.attack();
  });
  static final Combo borkBonk = Combo(["bork", "bonk", "bork", "bonk"], "reinforced bonk", (game) {
    game.world.add(Thunderstrike(position: game.fellowship.position));
    game.fellowship.attack();
  });
  static final Combo defenceBonk =
      Combo(['bonk', 'bonk', 'bonk', 'bonk'], 'bonk defence', (game) => game.fellowship.buffDefence());
  static final Combo move = Combo(["bork", "bork", "bonk", "bork"], 'move', (game) => game.fellowship.startWalking());

  static List<Combo> get all => [
        tripleBork,
        borkBonk,
        defenceBonk,
        move,
      ];
}
