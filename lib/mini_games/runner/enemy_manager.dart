import 'package:flame/components.dart';
import 'dart:math';

import './actors/enemy.dart';
import './hieron_quest.dart';

class EnemyManager extends Component with HasGameReference<HieronQuest> {
  late Random _random;
  late Timer _timer;
  late int _spawnLevel;

  EnemyManager() {
    _spawnLevel = 0;
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

    var newSpawnLevel = (game.score ~/ 5);
    if (_spawnLevel < newSpawnLevel) {
      _spawnLevel = newSpawnLevel;

      var newWaitTime = (4 / (1 + (0.5 * _spawnLevel)));

      _timer.stop();
      _timer = Timer(
        newWaitTime,
        onTick: () {
          spawnEnemy();
        },
        repeat: true,
      );
      _timer.start();
    }
  }
}
