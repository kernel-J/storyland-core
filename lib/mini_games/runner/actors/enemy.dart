import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import '../hieron_quest.dart';

enum EnemyType { demonBunny, whiteBunny, fantasyBunny }

class EnemyData {
  final String imageName;
  final double textureWidth;
  final double textureHeight;
  final int numOfColumns;
  final double velocity;

  const EnemyData({
    required this.imageName,
    required this.textureWidth,
    required this.textureHeight,
    required this.numOfColumns,
    required this.velocity,
  });
}

class Enemy extends SpriteAnimationComponent
    with HasGameReference<HieronQuest> {
  static const Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.demonBunny: EnemyData(
        imageName: 'enemies/demonic_bunny_running.png',
        textureHeight: 32,
        textureWidth: 32,
        numOfColumns: 8,
        velocity: 600),
    EnemyType.whiteBunny: EnemyData(
        imageName: 'enemies/white_bunny_idle.png',
        textureHeight: 32,
        textureWidth: 32,
        numOfColumns: 8,
        velocity: 200),
    EnemyType.fantasyBunny: EnemyData(
        imageName: 'enemies/fantasy_bunny_running.png',
        textureHeight: 32,
        textureWidth: 32,
        numOfColumns: 8,
        velocity: 400)
  };
  late Vector2 velocity;
  late EnemyType type;

  Enemy(EnemyType enemyType) : super(size: Vector2(75, 75)) {
    type = enemyType;
  }

  @override
  void onLoad() {
    final enemyData = _enemyDetails[type];
    velocity = Vector2(enemyData!.velocity, 0);
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(enemyData!.imageName),
      SpriteAnimationData.sequenced(
        amount: enemyData.numOfColumns,
        textureSize: Vector2(enemyData.textureWidth, enemyData.textureHeight),
        stepTime: 0.12,
      ),
    );

    flipHorizontally();

    y = game.canvasSize.g - 100;
    x = game.canvasSize.r - width;

    add(CircleHitbox.relative(0.5,
        parentSize: size, position: Vector2(size.r / 2 - 20, size.g / 2)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= velocity.r * dt;
  }

  @override
  void remove(Component component) {
    if (x < (-width)) {
      super.remove(component);
    }
  }
}
