import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/Combos/ComboHandler.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';

class Hud extends PositionComponent with HasGameRef<GGJ25Game> {
  late SpriteComponent rhytmIndicator;
  List<Component> comboList = [];
  Sprite greenButtonSprite = Sprite(game.images.fromCache(GfxAssets.redButton));
  Sprite redButtonSprite = Sprite(game.images.fromCache(GfxAssets.greenButton));

  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late final List<SpriteComponent> bars;

  @override
  FutureOr<void> onLoad() {
    position = Vector2(gameRef.camera.viewport.size.x / 2, 50);
    size = Vector2.all(24);
    rhytmIndicator = SpriteComponent(
      sprite: Sprite(game.images.fromCache(GfxAssets.rhytmIndicator)),
      position: Vector2(20, 20),
      size: Vector2(32, 64),
      anchor: Anchor.center,
      scale: Vector2(1.5, 3),
    );
    bars = [
      for (int i = 0; i < 4; i++)
        SpriteComponent(
          sprite: Sprite(game.images.fromCache(GfxAssets.rock2)),
          position: Vector2(i * 100, 0),
          size: Vector2.all(12),
          anchor: Anchor.center,
          scale: Vector2(1, 8),
        ),
      for (int i = 0; i < 4; i++)
        SpriteComponent(
          sprite: Sprite(game.images.fromCache(GfxAssets.rock2)),
          position: Vector2(i * 100, 0),
          size: Vector2.all(12),
          anchor: Anchor.center,
          scale: Vector2(1, 2),
        ),
    ];
    // bar = SpriteComponent(
    //     sprite: Sprite(game.images.fromCache(GfxAssets.rock2)),
    //     position: Vector2(position.x + 30, position.y),
    //     size: Vector2.all(24),
    //     anchor: Anchor.center,
    //     scale: Vector2(4, 4));
    // resetBar();
    add(rhytmIndicator);
    // add(bar);
    addAll(bars);
  }

  double time = 0;

  @override
  void update(double dt) {
    time += dt;
    _updateRhytm();
    _updateComboList();
  }

  void _updateRhytm() {
    print(game.combo.time % ComboHandler.timeBetweenNextPresses);
    if ((game.combo.time % ComboHandler.timeBetweenNextPresses) - 0.1 < 0.2) {
      rhytmIndicator.size = Vector2(24, 48);
      // rhytmIndicator.size = Vector2.all(0)
      // print('window');
      // remove(rhytmIndicator);
      // rhytmIndicator.add(SequenceEffect([
      //   ColorEffect(Colors.white, EffectController(duration: 0.05), opacityFrom: 0, opacityTo: 1),
      //   ColorEffect(Colors.white, EffectController(duration: 0.1), opacityFrom: 1, opacityTo: 0),
      // ]));
    } else {
      rhytmIndicator.size = Vector2(16, 32);
    }
    final divider = (1 / (ComboHandler.bpm / 60));
    final travelTime = divider * bars.length;
    for (var i = 0; i < bars.length; i++) {
      final tempo = ((time - divider * i) % travelTime) / travelTime;
      final bar = bars[i];
      bar.position = Vector2(bars.length * 100 - tempo * bars.length * 100 + 20, 12);
      if (bar.position.x < 0) {
        bar.position = Vector2(bars.length * 100, 12);
      }
    }
  }

  void _updateComboList() {
    removeAll(comboList);
    comboList = [];
    var matchingCombos = game.combo.currentlyMatchingCombos;
    var indexWhereToStartDisplayingCombo = game.combo.currentIndexOfHitToMatch;
    for (var combo in matchingCombos) {
      var indexOfComboList = matchingCombos.indexOf(combo).toDouble();
      var text = TextComponent(
        text: combo.name + ':',
        position: Vector2(100 - gameRef.camera.viewport.size.x / 2, 550 + 60 * indexOfComboList),
        size: Vector2(20, 20),
        anchor: Anchor.center,
        scale: Vector2(1, 1)
      );
      add(text);
      comboList.add(text);
      combo.inputs.asMap().forEach((indexOfInput, button) {
        if(indexWhereToStartDisplayingCombo > indexOfInput) return;
          var inputUiPosition = Vector2(
          210 + (indexOfInput - indexWhereToStartDisplayingCombo) * 40 - gameRef.camera.viewport.size.x / 2,
          550 + 60 * indexOfComboList);
        var spriteToAdd = SpriteComponent(
          sprite: _spritePathForButton(button),
          position: inputUiPosition,
          size: Vector2.all(20),
          anchor: Anchor.center,
          scale: Vector2(2, 2));
        comboList.add(spriteToAdd);
        add(spriteToAdd);
      });
    }
  }

  Sprite? _spritePathForButton(String input) {
    switch(input){
      case 'bonk': return greenButtonSprite;
      case 'bork': return redButtonSprite;
      default: return null;
    }
  }
}
