import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/game.dart';

import 'Combo.dart';

class ComboHandler extends Component with HasGameReference<GGJ25Game> {
  double timeSinceLastBeat = 0;
  List<Combo> combos = _allCombos();
  int currentIndexOfHitToMatch = 0;
  List<Combo> currentlyMatchingCombos = _allCombos();
  bool gameIsInRhytmWindow = false;
  // bool noteAlraedyHitInTHisBit = false;
  late Fellowship fellowship;

  static const double bpm = 135.0;
  static const double timeBetweenNextPresses = (1 / (bpm / 60));
  static const double beatTimeMargin = 10;
  static const double marginOfTimeError = timeBetweenNextPresses * beatTimeMargin;

  @override
  FutureOr<void> onLoad() {
    fellowship = game.children.where((x) => x is Fellowship).first as Fellowship;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastBeat += dt;
    if(timeSinceLastBeat > timeBetweenNextPresses + marginOfTimeError) {
      timeSinceLastBeat -= timeBetweenNextPresses;
      gameIsInRhytmWindow = true;
      // noteAlraedyHitInTHisBit = false;
    } else if(timeSinceLastBeat > timeBetweenNextPresses - marginOfTimeError) {
      gameIsInRhytmWindow = true;
    } else {
      gameIsInRhytmWindow = true;
    }
  }

  void comboInput(String input) {
    log(gameIsInRhytmWindow.toString());
    if(!gameIsInRhytmWindow){
      _resetCombo();
    }
    _appendToCombo(input);
    if(_comboIsFinished()){
      var comboToExecute = currentlyMatchingCombos[0].ComboEffect;
      log(currentlyMatchingCombos[0].Name + ' will fire');
      comboToExecute(fellowship, game);
      _resetCombo();
    } else {
      currentIndexOfHitToMatch++;
    }
  }

  bool _comboIsFinished(){
    return currentlyMatchingCombos.length == 1 && 
      currentlyMatchingCombos[0].Inputs.length == currentIndexOfHitToMatch + 1;
  }

  void _appendToCombo(String input){
    currentlyMatchingCombos = currentlyMatchingCombos
      .where((x) => x.Inputs[currentIndexOfHitToMatch] == input)
      .toList();
      log(input + ' was pressed, that\'s note with index #' + currentIndexOfHitToMatch.toString());
  }

  void _resetCombo() {
    currentlyMatchingCombos = combos;
    currentIndexOfHitToMatch = 0;
    log('combo reset');
  }

  static List<Combo> _allCombos() {
    return [
      new Combo(["bork", "bork", "bork"], "bork overdrive", (hero, game) => {log('am doggo')}),
      new Combo(["bork", "bonk"], "reinforced bonk", (hero, game) => {log('tons of damage')})
    ];
  }
}