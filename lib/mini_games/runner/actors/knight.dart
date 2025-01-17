import 'package:flame/components.dart';

import '../hieron_quest.dart';

const double GRAVITY = 1000;

class KnightPlayer extends SpriteAnimationComponent
    with HasGameReference<HieronQuest> {
  KnightPlayer({
    required super.position,
  }) : super(size: Vector2(200, 188), anchor: Anchor.center);

  Vector2 velocity = Vector2.zero();
  double yMax = 0.0;

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('knight_run_spritesheet.png'),
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(96, 84),
        stepTime: 0.12,
      ),
    );

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
}
