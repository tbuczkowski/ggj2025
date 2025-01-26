import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/Combos/Combo.dart';
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/sfx_assets.dart';

class ComboHandler extends Component with HasGameReference<GGJ25Game> {
  double time = 0;

  double timeSinceLastBeat = 0;
  int currentIndexOfHitToMatch = 0;
  List<Combo> currentlyMatchingCombos = Combos.all;
  bool gameIsInRhytmWindow = false;
  List<String> currentComboState = [];
  bool playSounds = false;

  double timeSinceLastComboInput = 0;

  // bool noteAlraedyHitInTHisBit = false;
  late Fellowship fellowship;

  static const double bpm = 120.0;
  static const double timeBetweenNextPresses = (1 / (bpm / 60));
  static const double beatTimeMargin = 0.3;
  static const double marginOfTimeError = timeBetweenNextPresses * beatTimeMargin;

  @override
  FutureOr<void> onLoad() {
    fellowship = game.fellowship;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    time += dt;
    timeSinceLastBeat += dt;
    timeSinceLastComboInput += dt;
    if (timeSinceLastComboInput > timeBetweenNextPresses + marginOfTimeError) {
      _resetCombo();
    }
    if (timeSinceLastBeat > timeBetweenNextPresses + marginOfTimeError) {
      // log('Outside rhythm window (1)');
      timeSinceLastBeat -= timeBetweenNextPresses;
      gameIsInRhytmWindow = false;
      // noteAlraedyHitInTHisBit = false;
    } else if (timeSinceLastBeat > timeBetweenNextPresses - marginOfTimeError) {
      if (!gameIsInRhytmWindow) GameAudioPlayer.playEffect(SfxAssets.metro, 0.02);
      // log('In rhythm!');
      gameIsInRhytmWindow = true;
    } else {
      // log('Outside rhythm window (2)');
      gameIsInRhytmWindow = false;
    }
  }

  void comboInput(String input) {
    //log(gameIsInRhytmWindow.toString());
    timeSinceLastComboInput = 0;
    // print(timeBetweenNextPresses);
    //print(time % timeBetweenNextPresses);
    if (game.fellowship.actionInProgress) {
      GameAudioPlayer.playEffect(SfxAssets.chop);
      return;
    }
    if (!gameIsInRhytmWindow) {
      _resetCombo();
      game.scoreComponent.resetMultiplier();
      (switch (input) {
        "bork" => GameAudioPlayer.playEffect(SfxAssets.fail1),
        "bonk" => GameAudioPlayer.playEffect(SfxAssets.fail2),
        _ => log('unknown input: ' + input),
      });
      return;
    }
    (switch (input) {
      "bork" => GameAudioPlayer.playEffect(SfxAssets.bongo1),
      "bonk" => GameAudioPlayer.playEffect(SfxAssets.bongo2),
      _ => log('unknown input: ' + input),
    });
    _appendToCombo(input);
    if (_comboIsFinished()) {
      game.scoreComponent.increaseMultiplier();
      var comboToExecute = currentlyMatchingCombos[0].comboEffect;
      log(currentlyMatchingCombos[0].name + ' will fire');
      comboToExecute(game);
      _resetCombo();
    } else {
      currentIndexOfHitToMatch++;
    }
  }

  bool _comboIsFinished() {
    return currentlyMatchingCombos.length == 1 &&
        currentIndexOfHitToMatch == currentlyMatchingCombos[0].inputs.length - 1;
  }

  void _appendToCombo(String input) {
    currentComboState.add(input);
    if (currentComboState.length > 4) {
      currentComboState.removeAt(0);
    }
    currentlyMatchingCombos = [...Combos.all].where(
      (c) {
        print((c.inputs.join(), currentComboState.join()));
        return c.inputs.join().startsWith(currentComboState.join());
      },
    ).toList();

    // if (currentlyMatchingCombos.length == 0) {
    //   log('Nothing matches, reset');
    //   _resetCombo();
    // }

    // currentlyMatchingCombos =
    //     currentlyMatchingCombos.where((x) => x.inputs[currentIndexOfHitToMatch] == input).toList();
    // log(input + ' was pressed, that\'s note with index #' + currentIndexOfHitToMatch.toString());
    log(input + ' was pressed, that\'s note with index #' + currentIndexOfHitToMatch.toString());
    log('Current streak: ${currentComboState.join('|')}');
  }

  void _resetCombo() {
    currentlyMatchingCombos = [...Combos.all];
    currentIndexOfHitToMatch = 0;
    currentComboState = [];
    log('combo reset');
  }
}
