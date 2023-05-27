import 'package:flutter/material.dart';
import 'package:spielblock/models/game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.name),
      ),
      body: const Center(
        child: Text('Game'),
      ),
    );
  }
}
