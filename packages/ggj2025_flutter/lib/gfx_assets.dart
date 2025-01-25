import 'package:flame/game.dart';

class GfxAssets {
  static const String smoke = 'smoke.png';
  static const String hero1Idle = 'heroes/Dude_Monster/Dude_Monster_Idle_4.png';
  static const String hero2Idle = 'heroes/Owlet_Monster/Owlet_Monster_Idle_4.png';
  static const String hero3Idle = 'heroes/Pink_Monster/Pink_Monster_Idle_4.png';

  static const String hero1Walk = 'heroes/Dude_Monster/Dude_Monster_Walk_6.png';
  static const String hero2Walk = 'heroes/Owlet_Monster/Owlet_Monster_Walk_6.png';
  static const String hero3Walk = 'heroes/Pink_Monster/Pink_Monster_Walk_6.png';

  static const String hero1Attack1 = 'heroes/Dude_Monster/Dude_Monster_Attack1_4.png';
  static const String hero2Attack1 = 'heroes/Owlet_Monster/Owlet_Monster_Attack1_4.png';
  static const String hero3Attack1 = 'heroes/Pink_Monster/Pink_Monster_Attack1_4.png';

  static const String hero1Attack2 = 'heroes/Dude_Monster/Dude_Monster_Attack2_6.png';
  static const String hero2Attack2 = 'heroes/Owlet_Monster/Owlet_Monster_Attack2_6.png';
  static const String hero3Attack2 = 'heroes/Pink_Monster/Pink_Monster_Attack2_6.png';

  static const String tilemap = 'tilemap_16x16.png';

  static const String bubble = 'background/common/bubble.png';

  static const String rock1 = 'objects/Rock1.png';
  static const String rock2 = 'objects/Rock2.png';
  static const String barrel = 'objects/Barrel.png';
  static const String chest = 'objects/Chest.png';

  static const Map<String, String> grassMap = {
    'grass1': 'objects/Grass1.png',
    'grass2': 'objects/Grass2.png',
    'grass3': 'objects/Grass3.png',
    'grass4': 'objects/Grass4.png',
  };

  static const String rhytmIndicator = 'ui/music.png';
  static const String greenButton = 'ui/green-button.png';
  static const String redButton = 'ui/red-button.png';

  static const String jellyfishIdle = 'enemies/Jellyfish/Idle.png';
  static const String jellyfishWalk = 'enemies/Jellyfish/Walk.png';
  static const String jellyfishAttack = 'enemies/Jellyfish/Attack.png';
  static const String jellyfishHurt = 'enemies/Jellyfish/Hurt.png';
  static const String jellyfishDeath = 'enemies/Jellyfish/Death.png';

  static const String swordfishIdle = 'enemies/Swordfish/Idle.png';
  static const String swordfishWalk = 'enemies/Swordfish/Walk.png';
  static const String swordfishAttack = 'enemies/Swordfish/Attack.png';
  static const String swordfishHurt = 'enemies/Swordfish/Hurt.png';
  static const String swordfishDeath = 'enemies/Swordfish/Death.png';

  static const String anglerfishIdle = 'enemies/Anglerfish/Idle.png';
  static const String anglerfishWalk = 'enemies/Anglerfish/Walk.png';
  static const String anglerfishAttack = 'enemies/Anglerfish/Attack.png';
  static const String anglerfishHurt = 'enemies/Anglerfish/Hurt.png';
  static const String anglerfishDeath = 'enemies/Anglerfish/Death.png';

  static const String eelIdle = 'enemies/Eel/Idle.png';
  static const String eelWalk = 'enemies/Eel/Walk.png';
  static const String eelAttack = 'enemies/Eel/Attack.png';
  static const String eelHurt = 'enemies/Eel/Hurt.png';
  static const String eelDeath = 'enemies/Eel/Death.png';

  static const String octopusIdle = 'enemies/Octopus/Idle.png';
  static const String octopusWalk = 'enemies/Octopus/Walk.png';
  static const String octopusAttack = 'enemies/Octopus/Attack.png';
  static const String octopusHurt = 'enemies/Octopus/Hurt.png';
  static const String octopusDeath = 'enemies/Octopus/Death.png';

  static const String explodingFishIdle = 'enemies/Exploding_Fish/Idle.png';
  static const String explodingFishWalk = 'enemies/Exploding_Fish/Walk.png';
  static const String explodingFishAttack = 'enemies/Exploding_Fish/Attack.png';
  static const String explodingFishHurt = 'enemies/Exploding_Fish/Hurt.png';
  static const String explodingFishDeath = 'enemies/Exploding_Fish/Death.png';

  static const String floaterIdle = 'enemies/Floater/Idle.png';
  static const String floaterWalk = 'enemies/Floater/Walk.png';
  static const String floaterAttack = 'enemies/Floater/Attack.png';
  static const String floaterHurt = 'enemies/Floater/Hurt.png';
  static const String floaterDeath = 'enemies/Floater/Death.png';

  static const String sirenWarriorIdle = 'enemies/Siren_Warrior/Idle.png';
  static const String sirenWarriorWalk = 'enemies/Siren_Warrior/Walk.png';
  static const String sirenWarriorAttack = 'enemies/Siren_Warrior/Attack.png';
  static const String sirenWarriorHurt = 'enemies/Siren_Warrior/Hurt.png';
  static const String sirenWarriorDeath = 'enemies/Siren_Warrior/Death.png';

  static const String floaterKnightIdle = 'enemies/Floater_Knight/Idle.png';
  static const String floaterKnightWalk = 'enemies/Floater_Knight/Walk.png';
  static const String floaterKnightAttack = 'enemies/Floater_Knight/Attack.png';
  static const String floaterKnightHurt = 'enemies/Floater_Knight/Hurt.png';
  static const String floaterKnightDeath = 'enemies/Floater_Knight/Death.png';

  static const String iceMissileFlying = 'objects/ice_missile1/flying.png';
  static const String thunderstrike = 'thunderstrike.png';

  static Future<void> loadAssets(FlameGame gameRef) =>
      gameRef.images.loadAll([
        hero1Idle,
        hero2Idle,
        hero3Idle,
        hero1Walk,
        hero2Walk,
        hero3Walk,
        hero1Attack1,
        hero2Attack1,
        hero3Attack1,
        hero1Attack2,
        hero2Attack2,
        hero3Attack2,
        tilemap,
        bubble,
        rock1,
        rock2,
        barrel,
        chest,
        rhytmIndicator,
        greenButton,
        redButton,
        grassMap['grass1']!,
        grassMap['grass2']!,
        grassMap['grass3']!,
        grassMap['grass4']!,
        jellyfishIdle,
        jellyfishWalk,
        jellyfishAttack,
        jellyfishHurt,
        jellyfishDeath,
        swordfishIdle,
        swordfishWalk,
        swordfishAttack,
        swordfishHurt,
        swordfishDeath,
        anglerfishIdle,
        anglerfishWalk,
        anglerfishAttack,
        anglerfishHurt,
        anglerfishDeath,
        eelIdle,
        eelWalk,
        eelAttack,
        eelHurt,
        eelDeath,
        octopusIdle,
        octopusWalk,
        octopusAttack,
        octopusHurt,
        octopusDeath,
        explodingFishIdle,
        explodingFishWalk,
        explodingFishAttack,
        explodingFishHurt,
        explodingFishDeath,
        floaterIdle,
        floaterWalk,
        floaterAttack,
        floaterHurt,
        floaterDeath,
        floaterKnightIdle,
        floaterKnightWalk,
        floaterKnightAttack,
        floaterKnightHurt,
        floaterKnightDeath,
        sirenWarriorIdle,
        sirenWarriorWalk,
        sirenWarriorAttack,
        sirenWarriorHurt,
        sirenWarriorDeath,
        iceMissileFlying,
        smoke,
        thunderstrike,
      ]);
}
