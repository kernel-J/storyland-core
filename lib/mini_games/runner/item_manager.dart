import 'package:flame/components.dart';
import 'dart:math';

import './actors/item.dart';
import './hieron_quest.dart';

class ItemManager extends Component with HasGameReference<HieronQuest> {
  final Random _random = Random();
  late Timer _timer;

  ItemManager() {
    _timer = Timer(
      5,
      onTick: () {
        final randomPosition = getRandomPosition();
        addItem(randomPosition);
      },
      repeat: true,
    );
  }

  Vector2 getRandomPosition() {
    final limit = game.size.y / 2;
    double y = _random.nextDouble() * (game.size.y - 100);
    if (y < limit) {
      y = limit;
    }
    return Vector2(game.size.x, y);
  }

  void addItem(position) {
    final item = Item(position: position);
    game.world.add(item);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
  }
}
