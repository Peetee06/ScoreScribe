import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_screen.dart';

class TabsTestScreen extends TestScreen {
  final _gamesTab = find.byKey(const ValueKey('gamesTab'));
  final _newGameTab = find.byKey(const ValueKey('newGameTab'));
  final _menuTab = find.byKey(const ValueKey('menuTab'));

  TabsTestScreen(WidgetTester tester) : super(tester);

  @override
  Future<bool> isReady({Duration? timeout}) async {
    if (timeout != null) {
      throw UnimplementedError('timeout is not implemented for TabsTestScreen');
    }
    return tester.any(_gamesTab);
  }

  @override
  Future<bool> isLoading({Duration? timeout}) async {
    return !(await isReady(timeout: timeout));
  }

  Future<void> tapGamesTab() async {
    await tester.tap(_gamesTab);
  }

  Future<void> tapNewGameTab() async {
    await tester.tap(_newGameTab);
  }

  Future<void> tapMenuTab() async {
    await tester.tap(_menuTab);
  }
}
