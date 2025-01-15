import 'package:flame/components.dart';

import '../hieron_quest.dart';

class KnightPlayer extends SpriteAnimationComponent
    with HasGameReference<HieronQuest> {
  KnightPlayer({
    required super.position,
  }) : super(size: Vector2.all(200), anchor: Anchor.center);

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
  }
}
