import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spielblock/data/dummy_games.dart';
import 'package:spielblock/screens/tabs.dart';
import 'package:spielblock/providers/games_provider.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  addDummyData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.light,
      home: const Tabs(),
    );
  }
}

void addDummyData() {
  final gamesNotifier = GamesNotifier();
  for (final game in dummyGames) {
    gamesNotifier.addGame(game);
  }
}
