import 'package:flame/game.dart';

class GfxAssets {
  static const String hero1Idle = 'heroes/Dude_Monster/Dude_Monster_Idle_4.png';
  static const String hero2Idle = 'heroes/Owlet_Monster/Owlet_Monster_Idle_4.png';
  static const String hero3Idle = 'heroes/Pink_Monster/Pink_Monster_Idle_4.png';

  static Future<void> loadAssets(FlameGame gameRef) => gameRef.images.loadAll([
      hero1Idle,
      hero2Idle,
      hero3Idle,
    ]);
}