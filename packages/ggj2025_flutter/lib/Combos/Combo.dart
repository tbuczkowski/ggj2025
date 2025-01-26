import 'package:flame/game.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/missiles/ice_missile.dart';
import 'package:ggj2025_flutter/objects/missiles/thunderstrike.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';

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
  static final Combo move = Combo(["bork", "bork", "bonk", "bork"], 'move', (game) {
    game.fellowship.startWalking();
    Future.delayed(Duration(milliseconds: 500), () {
      GameAudioPlayer.playEffect(SfxAssets.b2, 0.3);
    });
  });
  static final Combo tripleBork = Combo(["bonk", "bonk", "bork", "bork"], "ice missile", (game) {
    game.world.add(IceMissile(position: game.fellowship.position + Vector2(20, 0)));
    game.fellowship.attack(HeroType.blue);
    Future.delayed(Duration(milliseconds: 500), () {
      GameAudioPlayer.playEffect(SfxAssets.b1, 0.3);
    });
  });
  static final Combo borkBonk = Combo(["bork", "bonk", "bork", "bonk"], "thunderstrike", (game) {
    game.world.add(Thunderstrike(position: game.fellowship.position + Vector2(120, -20)));
    game.fellowship.attack(HeroType.white);
    Future.delayed(Duration(milliseconds: 500), () {
      GameAudioPlayer.playEffect(SfxAssets.b3, 0.3);
    });
  });
  static final Combo defenceBonk = Combo(['bonk', 'bork', 'bork', 'bonk'], 'bubble defence', (game) {
    game.fellowship.buffDefence();
    game.fellowship.attack(HeroType.pink);
    Future.delayed(Duration(milliseconds: 500), () {
      GameAudioPlayer.playEffect(SfxAssets.b4, 0.3);
    });
  });

  static List<Combo> get all => [
        tripleBork,
        borkBonk,
        defenceBonk,
        move,
      ];
}
