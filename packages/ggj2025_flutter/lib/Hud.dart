import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/ComboInfo.dart';
import 'package:ggj2025_flutter/Combos/Combo.dart';
import 'package:ggj2025_flutter/Combos/ComboHandler.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/gfx_assets.dart';
import 'package:ggj2025_flutter/objects/ui_icon.dart';

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

  late final Sprite canGo;
  late final Sprite hold;

  @override
  FutureOr<void> onLoad() {
    canGo = Sprite(
      game.images.fromCache(GfxAssets.iconsMap),
      srcPosition: UIIconType.plus,
      srcSize: Vector2.all(50),
    );

    hold = Sprite(
      game.images.fromCache(GfxAssets.iconsMap),
      srcPosition: UIIconType.minus,
      srcSize: Vector2.all(50),
    );

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
      for (int i = 0; i < 8; i++)
        SpriteComponent(
          sprite: canGo,
          position: Vector2(i * 100, 0),
          size: Vector2.all(32),
          anchor: Anchor.center,
          // scale: Vector2(1, 8),
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

    BONGOTIMETEXT = TextComponent(
      text: _bongoText,
      textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          )),
      anchor: Anchor.center,
      position: Vector2(game.camera.viewport.position.x, game.camera.viewport.position.y),
    );
  }

  double time = 0;

  @override
  void update(double dt) {
    time += dt;
    _updateRhytm();
    _updateComboList();
    if(game.bonusBongo.bongoTimeActive){
      add(BONGOTIMETEXT);
    } else if(children.any((x) => x == BONGOTIMETEXT)) {
      remove(BONGOTIMETEXT);
    }
  }

  void _updateRhytm() {
    //print(game.combo.time % ComboHandler.timeBetweenNextPresses);
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
      // bar.scale = game.fellowship.actionInProgress ? Vector2(1, 4) : Vector2(1, 8);
      bar.sprite = game.fellowship.actionInProgress ? hold : canGo;
      bar.position = Vector2(bars.length * 100 - tempo * bars.length * 100 + 20, 12);
      if (bar.position.x < 0) {
        bar.position = Vector2(bars.length * 100, 12);
      }
    }
  }

  void _updateComboList() {
    removeAll(comboList);
    var components = _comboComponentsToDisplay();
    comboList = components
        .map((x) {
          var res = List<Component>.from(x.buttons);
          res.add(x.description);
          return res;
        })
        .expand((x) => x)
        .toList();
    addAll(comboList);
  }

  List<ComboInfo> _comboComponentsToDisplay() {
    const numberOfRows = 2;
    return _combosToDisplay().asMap().entries.map((x) {
      var baseXPos = _xBasePositionForComboInfo(x.key, numberOfRows);
      var baseYPos = _yBasePositionForComboInfo(x.key, numberOfRows);
      return ComboInfo(
          TextComponent(
              text: x.value.name + ':',
              position: Vector2(baseXPos, baseYPos),
              size: Vector2(20, 20),
              anchor: Anchor.centerLeft,
              scale: Vector2(1, 1)),
          x.value.inputs.asMap().entries.map((y) {
            return SpriteComponent(
                sprite: _spritePathForButton(y.value),
                position: Vector2(baseXPos + 170 + 40 * y.key, baseYPos),
                size: Vector2.all(20),
                anchor: Anchor.centerLeft,
                scale: Vector2(2, 2));
          }).toList());
    }).toList();
  }

  List<Combo> _combosToDisplay() {
    var matchingCombos = game.combo.currentlyMatchingCombos;
    var indexWhereToStartDisplayingCombo = game.combo.currentIndexOfHitToMatch;
    return matchingCombos.map((combo) {
      return Combo(
          combo.inputs
              .asMap()
              .entries
              .where((x) => indexWhereToStartDisplayingCombo <= x.key)
              .map((x) => x.value)
              .toList(),
          combo.name,
          combo.comboEffect);
    }).toList();
  }

  double _yBasePositionForComboInfo(int indexOfCombo, int numberOfRows) {
    var bottomOfScreen = gameRef.camera.viewport.size.y;
    return bottomOfScreen * 0.9 - 60 * (indexOfCombo % numberOfRows);
  }

  double _xBasePositionForComboInfo(int indexOfCombo, int numberOfRows) {
    var leftSide = -gameRef.camera.viewport.size.x / 2;
    return leftSide + (indexOfCombo / numberOfRows).toInt() * 500;
  }

  late TextComponent BONGOTIMETEXT;
  String get _bongoText => 'HIT THOSE BONGOS! YOU HAVE ${game.bonusBongo.bongoTimeLeft} LEFT';






  //   for (var combo in matchingCombos) {
  //     var indexOfComboList = matchingCombos.indexOf(combo).toDouble();
  //     var text = TextComponent(
  //         text: combo.name + ':',
  //         position: Vector2(
  //             100 - gameRef.camera.viewport.size.x / 2,
  //             gameRef.camera.viewport.size.y - 100 - 60 * indexOfComboList),
  //         size: Vector2(20, 20),
  //         anchor: Anchor.center,
  //         scale: Vector2(1, 1));
  //     add(text);
  //     comboList.add(text);
  //     combo.inputs.asMap().forEach((indexOfInput, button) {
  //       if (indexWhereToStartDisplayingCombo > indexOfInput) return;
  //       var inputUiPosition = Vector2(
  //           210 + (indexOfInput - indexWhereToStartDisplayingCombo) * 40 - gameRef.camera.viewport.size.x / 2,
  //           gameRef.camera.viewport.size.y - 100 - 60 * indexOfComboList);
  //       var spriteToAdd = SpriteComponent(
  //           sprite: _spritePathForButton(button),
  //           position: inputUiPosition,
  //           size: Vector2.all(20),
  //           anchor: Anchor.center,
  //           scale: Vector2(2, 2));
  //       comboList.add(spriteToAdd);
  //       add(spriteToAdd);
  //     });
  //   }
  // }

  Sprite? _spritePathForButton(String input) {
    switch (input) {
      case 'bonk':
        return greenButtonSprite;
      case 'bork':
        return redButtonSprite;
      default:
        return null;
    }
  }
}
