import 'dart:developer';

import 'DoggoCombo.dart';

class DoggoComboHandler {
  List<DoggoCombo> combos = _allCombos();
  int currentIndexOfHitToMatch = 0;
  DateTime? momentOfPreviousInput = null;
  List<DoggoCombo> currentlyMatchingCombos = _allCombos();

  void comboInput(String input) {
    var now = DateTime.now();
    momentOfPreviousInput = momentOfPreviousInput ?? now;
    if(!_isWithinComboMargin(now)){
      _resetCombo();
    }
    _appendToCombo(input, now);
    if(_comboIsFinished()){
      var comboToExecute = currentlyMatchingCombos[0].ComboEffect;
      log(currentlyMatchingCombos[0].Name + ' will fire');
      comboToExecute();
      _resetCombo();
    } else {
      currentIndexOfHitToMatch++;
    }
  }

  bool _comboIsFinished(){
    return currentlyMatchingCombos.length == 1 && 
      currentlyMatchingCombos[0].Inputs.length == currentIndexOfHitToMatch + 1;
  }

  void _appendToCombo(String input, DateTime momentofLatestInput){
    momentOfPreviousInput = momentofLatestInput;
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

  bool _isWithinComboMargin(DateTime inputComboMoment) {
    var timeSincePreviousInput = inputComboMoment.difference(momentOfPreviousInput!).inMilliseconds.abs();
    return timeSincePreviousInput < 400 && timeSincePreviousInput > 100;
  }

  static List<DoggoCombo> _allCombos() {
    return [
      new DoggoCombo(["bork", "bork", "bork"], "bork overdrive", () => {log('am doggo')}),
      new DoggoCombo(["bork", "bonk"], "reinforced bonk", () => {log('tons of damage')})
    ];
  }
}