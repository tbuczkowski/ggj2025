import 'dart:math';

import 'package:flame/components.dart';
import 'package:ggj2025_flutter/actors/enemy_band.dart';
import 'package:ggj2025_flutter/actors/fellowship.dart';
import 'package:ggj2025_flutter/game.dart';
import 'package:ggj2025_flutter/objects/rock.dart';

class EventGenerator {
  final Random random = Random.secure();
  double timeSinceLastEvent = 0;

  void updateTimeSinceLastEvent(double dt) => timeSinceLastEvent += dt;

  bool shouldGenerateFightEvent(FellowshipState state) =>
      state.distanceTravelledSinceLastEvent >= 500;

  void addRandomRockAppearsEvent(World world) {
    if (timeSinceLastEvent > 1) {
      world.add(Rock(position: Vector2(game.cameraTarget.position.x, 32)));
      timeSinceLastEvent = 0;
    }
  }

  void addEventToScene(World world, Fellowship fellowship) {
    // fellowship.stopWalking();
    world.add(EnemyBand.randomBand(
      position: Vector2(fellowship.position.x + 2000, fellowship.position.y),
      bandSize: Random().nextInt(3) + 1,
    ));
  }
}
