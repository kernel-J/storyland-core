import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:storyland/mini_games/runner/enemy_manager.dart';

import 'actors/knight.dart';

class HieronQuest extends FlameGame with TapDetector, HasCollisionDetection {
  late KnightPlayer _knight;
  late EnemyManager _enemyManager;

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    final parallax = await loadParallaxComponent([
      ParallaxImageData('parallax/background_1.png'),
      ParallaxImageData(
        'parallax/_10_distant_clouds.png',
      ),
      ParallaxImageData(
        'parallax/_09_distant_clouds1.png',
      ),
      ParallaxImageData(
        'parallax/_08_clouds.png',
      ),
      ParallaxImageData(
        'parallax/_05_hill1.png',
      ),
      ParallaxImageData(
        'parallax/_01_ground.png',
      )
    ],
        baseVelocity: Vector2(1, 0),
        repeat: ImageRepeat.repeat,
        velocityMultiplierDelta: Vector2(2, 0));
    world.add(parallax);

    await images.loadAll([
      'knight_run_spritesheet.png',
      'knight_hurt_spritesheet.png',
      'enemies/demonic_bunny_running.png',
      'enemies/fantasy_bunny_running.png',
      'enemies/white_bunny_idle.png'
    ]);

    _enemyManager = EnemyManager();
    world.add(_enemyManager);

    camera.viewfinder.anchor = Anchor.topLeft;
    _knight = KnightPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_knight);
  }

  @override
  void onTapDown(TapDownInfo info) {
    _knight.jump();
  }
}
