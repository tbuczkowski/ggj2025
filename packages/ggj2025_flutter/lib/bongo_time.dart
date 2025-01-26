import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ggj2025_flutter/game.dart';

class BongoTime extends PositionComponent with HasGameRef<GGJ25Game> {
  static const int bongoTimeThreshhold = 10;
  int nextBongoTimeThreshgold = bongoTimeThreshhold;
  bool bongoTimeActive = false;
  double bongoTimeFor = 0;
  int bonus = 0;

  int get bonusValue => bonus;
  double get bongoTimeLeft => bongoTimeFor;

  @override
  void update(double dt) {
    bongoTimeFor -= dt;
    if(!bongoTimeActive && gameRef.scoreComponent.currentScore > nextBongoTimeThreshgold) {
      bongoTimeActive = true;
      // add(BONGOTIMETEXT);
      bongoTimeFor = 5;
    } else if (bongoTimeActive && bongoTimeFor <= 0) {
      bongoTimeActive = false;
      // remove(BONGOTIMETEXT);
      nextBongoTimeThreshgold = gameRef.scoreComponent.currentScore - (gameRef.scoreComponent.currentScore % bongoTimeThreshhold) + bongoTimeThreshhold;
    }
  }
}