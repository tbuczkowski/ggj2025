import 'package:flame/game.dart';

class GfxAssets {
  static const String hero1Idle = 'heroes/Dude_Monster/Dude_Monster_Idle_4.png';
  static const String hero2Idle =
      'heroes/Owlet_Monster/Owlet_Monster_Idle_4.png';
  static const String hero3Idle = 'heroes/Pink_Monster/Pink_Monster_Idle_4.png';

  static const String hero1Walk = 'heroes/Dude_Monster/Dude_Monster_Walk_6.png';
  static const String hero2Walk =
      'heroes/Owlet_Monster/Owlet_Monster_Walk_6.png';
  static const String hero3Walk = 'heroes/Pink_Monster/Pink_Monster_Walk_6.png';

  static const String hero1Attack1 =
      'heroes/Dude_Monster/Dude_Monster_Attack1_4.png';
  static const String hero2Attack1 =
      'heroes/Owlet_Monster/Owlet_Monster_Attack1_4.png';
  static const String hero3Attack1 =
      'heroes/Pink_Monster/Pink_Monster_Attack1_4.png';

  static const String hero1Attack2 =
      'heroes/Dude_Monster/Dude_Monster_Attack2_6.png';
  static const String hero2Attack2 =
      'heroes/Owlet_Monster/Owlet_Monster_Attack2_6.png';
  static const String hero3Attack2 =
      'heroes/Pink_Monster/Pink_Monster_Attack2_6.png';

  static const String tilemap = 'tilemap_16x16.png';

  static const String bubble = 'background/common/bubble.png';

  static const String rock1 = 'objects/Rock1.png';
  static const String rock2 = 'objects/Rock2.png';

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

  static Future<void> loadAssets(FlameGame gameRef) => gameRef.images.loadAll([
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
      ]);
}
