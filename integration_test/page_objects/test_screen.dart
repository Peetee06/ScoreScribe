import 'package:flutter_test/flutter_test.dart';

abstract class TestScreen {
  final WidgetTester tester;

  TestScreen(this.tester);

  Future<bool> isLoading({Duration? timeout}) async {
    return !(await isReady(timeout: timeout));
  }

  Future<bool> isReady({Duration? timeout});
}
