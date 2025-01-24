import 'package:flame/game.dart';

class GfxAssets {
  static const String hero1Idle = 'heroes/Dude_Monster/Dude_Monster_Idle_4.png';
  static const String hero2Idle = 'heroes/Owlet_Monster/Owlet_Monster_Idle_4.png';
  static const String hero3Idle = 'heroes/Pink_Monster/Pink_Monster_Idle_4.png';

  static const String hero1IWalk = 'heroes/Dude_Monster/Dude_Monster_Walk_6.png';
  static const String hero2Walk = 'heroes/Owlet_Monster/Owlet_Monster_Walk_6.png';
  static const String hero3Walk = 'heroes/Pink_Monster/Pink_Monster_Walk_6.png';

  static const String hero1IAttack1 = 'heroes/Dude_Monster/Dude_Monster_Attack1_4.png';
  static const String hero2Attack1 = 'heroes/Owlet_Monster/Owlet_Monster_Attack1_4.png';
  static const String hero3Attack1 = 'heroes/Pink_Monster/Pink_Monster_Attack1_4.png';

  static const String hero1IAttack2 = 'heroes/Dude_Monster/Dude_Monster_Attack2_6.png';
  static const String hero2Attack2 = 'heroes/Owlet_Monster/Owlet_Monster_Attack2_6.png';
  static const String hero3Attack2 = 'heroes/Pink_Monster/Pink_Monster_Attack2_6.png';

  static Future<void> loadAssets(FlameGame gameRef) => gameRef.images.loadAll([
        hero1Idle,
        hero2Idle,
        hero3Idle,
        hero1IWalk,
        hero2Walk,
        hero3Walk,
        hero1IAttack1,
        hero2Attack1,
        hero3Attack1,
        hero1IAttack2,
        hero2Attack2,
        hero3Attack2,
      ]);
}
