import 'package:flame/components.dart';
import 'dart:math';

import './actors/enemy.dart';
import './hieron_quest.dart';

class EnemyManager extends Component with HasGameReference<HieronQuest> {
  late Random _random;
  late Timer _timer;

  EnemyManager() {
    _random = Random();
    _timer = Timer(
      4,
      onTick: () {
        spawnEnemy();
      },
      repeat: true,
    );
  }

  void spawnEnemy() {
    final randonNumber = _random.nextInt(EnemyType.values.length);
    final randomEnemyType = EnemyType.values.elementAt(randonNumber);
    final enemy = Enemy(randomEnemyType);
    game.world.add(enemy);
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
