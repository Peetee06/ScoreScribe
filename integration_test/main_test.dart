import 'dart:io';

import 'package:emulators/emulators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:scorecard/main.dart' as app;

import 'page_objects/tabs_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const androidScreenshotPath = 'screenshots/store/android';
  const iosScreenshotPath = 'screenshots/store/ios';

  WidgetsApp.debugAllowBannerOverride = false;

  ScreenshotHelper? screenshot;

  setUpAll(() async {
    final emulators = await Emulators.build();
    screenshot = emulators.screenshotHelper(
      androidPath: androidScreenshotPath,
      iosPath: iosScreenshotPath,
    );
    await screenshot!.cleanStatusBar();
  });

  group('end-to-end-test', () {
    testWidgets('render games and navigate to menu', (tester) async {
      // Build the app.
      app.main();

      print('running tests');

      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump();
      print('creating first screenshot');

      // await binding.takeScreenshot('${screenshotDirectory}screenshot-1');
      await screenshot!.capture('home_screen');

      // TabsTestScreen tabsTestScreen = TabsTestScreen(tester);
      // await tester.pump();

      // await expectLater(tabsTestScreen.isReady(), completion(true));
      // await tabsTestScreen.tapMenuTab();
      // await tester.pumpAndSettle();

      // print('Creating second screenshot');

      // expect(find.text('About'), findsOneWidget);
      // await screenshot!.capture('menu_screen');
      // await binding.takeScreenshot('${screenshotDirectory}screenshot-4');
    });
  });
}
