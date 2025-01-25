import 'dart:async';
import 'dart:developer';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/actors/heroes/hero.dart';
import 'package:ggj2025_flutter/game.dart';

import 'Combo.dart';

class ComboHandler extends Component with HasGameReference<GGJ25Game> {
  double timeSinceLastBeat = 0;
  List<Combo> combos = _allCombos();
  int currentIndexOfHitToMatch = 0;
  List<Combo> currentlyMatchingCombos = _allCombos();
  bool gameIsInRhytmWindow = false;
  late Fellowship fellowship;

  static const double bpm = 135.0;
  static const double timeBetweenNextPressesInDt = (1 / (bpm / 60)) * 1000000;
  static const double beatTimeMargin = 0.05;
  static const double marginOfTimeError = timeBetweenNextPressesInDt * beatTimeMargin;

  @override
  FutureOr<void> onLoad() {
    fellowship = game.children.where((x) => x is Fellowship).first as Fellowship;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceLastBeat += dt;
    if(timeSinceLastBeat > timeBetweenNextPressesInDt + marginOfTimeError) {
      timeSinceLastBeat -= timeBetweenNextPressesInDt;
      gameIsInRhytmWindow = false;
    } else if(timeSinceLastBeat > timeBetweenNextPressesInDt - marginOfTimeError) {
      gameIsInRhytmWindow = true;
    } else {
      gameIsInRhytmWindow = false;
    }
  }

  void comboInput(String input) {
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
      log(input + ' was pressed');
  }

  void _resetCombo() {
    currentlyMatchingCombos = combos;
    currentIndexOfHitToMatch = 0;
    log('combo reset');//todo some async binding with timer based combo system instead of ad hoc time measurement?
  }

  static List<Combo> _allCombos() {
    return [
      new Combo(["bork", "bork", "bork"], "bork overdrive", (hero, game) => {log('am doggo')}),
      new Combo(["bork", "bonk"], "reinforced bonk", (hero, game) => {log('tons of damage')})
    ];
  }
}