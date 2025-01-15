import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'mini_games/runner/hieron_quest.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GameWidget<HieronQuest>.controlled(
    gameFactory: HieronQuest.new,
  ));
}
