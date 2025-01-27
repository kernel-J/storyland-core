import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:storyland/mini_games/runner/actors/enemy.dart';

import '../hieron_quest.dart';

const double GRAVITY = 1000;

class KnightPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<HieronQuest> {
  KnightPlayer({
    required super.position,
  }) : super(size: Vector2(200, 188), anchor: Anchor.center);

  Vector2 velocity = Vector2.zero();
  double yMax = 0.0;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation hitAnimation;

  @override
  void onLoad() {
    runAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('knight_run_spritesheet.png'),
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(96, 84),
        stepTime: 0.1,
      ),
    );

    hitAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('knight_hurt_spritesheet.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(96, 84),
        stepTime: 0.1,
      ),
    );

    animation = runAnimation;
    add(CircleHitbox.relative(0.4,
        parentSize: size, position: Vector2(size.r / 2 - 35, size.g / 2 - 35)));

    yMax = y;
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity.g += GRAVITY * dt;
    y += velocity.g * dt;

    if (isOnGround()) {
      y = yMax;
      velocity.g = 0.0;
    }
  }

  bool isOnGround() {
    return (y >= yMax);
  }

  void jump() {
    if (isOnGround()) {
      velocity.g = -600;
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      if (intersectionPoints.length == 2) {
        animation = hitAnimation;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      animation = runAnimation;
    }
  }
}
