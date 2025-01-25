import 'package:flame/components.dart';
import 'package:ggj2025_flutter/game.dart';

class CameraTarget extends PositionComponent with HasGameRef<GGJ25Game> {

  final PositionComponent target;

  CameraTarget({
    super.position,
    required this.target,
  });

  @override
  void update(double dt) {
    if (game.fellowship.isDead) {
      removeFromParent();
    } else {
      position = target.position;

      position.y -= 128.0;

      // TODO: put things on scene as the fellowship moves forward
      // if (position.x + (game.size.x / 2) > positionOfNextEvent) {
      //   // load next thing - enemies, collectibles... etc.
      // }
    }

    super.update(dt);
  }
}