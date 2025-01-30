import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import '../hieron_quest.dart';
import '../actors/knight.dart';

class Item extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<HieronQuest> {
  Item({
    required super.position,
  }) : super(size: Vector2(30, 30));

  final Vector2 velocity = Vector2(100, 0);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('collectables/spinning_coin.png'),
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(16, 16),
        stepTime: 0.12,
      ),
    );

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

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is KnightPlayer) {
      if (intersectionPoints.length == 2) {
        game.score += 1;
        removeFromParent();
      }
    }
  }
}
