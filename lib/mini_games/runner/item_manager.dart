import 'package:flame/components.dart';
import 'dart:math';

import './actors/item.dart';
import './hieron_quest.dart';

class ItemManager extends Component with HasGameReference<HieronQuest> {
  late Timer _timer;

  ItemManager() {
    _timer = Timer(
      5,
      onTick: () {
        addItem();
      },
      repeat: true,
    );
  }

  void addItem() {
    final item = Item();
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
