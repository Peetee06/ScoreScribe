import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() async {
  const androidScreenshotPath = 'screenshots/store/android';
  const iosScreenshotPath = 'screenshots/store/ios';

  final driver = await FlutterDriver.connect();
  final emulators = await Emulators.build();
  final screenshot = emulators.screenshotHelper(
    androidPath: androidScreenshotPath,
    iosPath: iosScreenshotPath,
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();
    await screenshot.cleanStatusBar();
  });

  tearDownAll(() async {
    await driver.close();
  });

  group('end-to-end test', () {
    test('Navigate and Screenshot', () async {
      await driver.runUnsynchronized(() async {
        final menuTab = find.byValueKey('menuTab');

        await screenshot.capture('home_screen');

        await driver.tap(menuTab);
      });

      driver.waitFor(find.text('About'));

      await screenshot.capture('menu_screen');

      await Future.delayed(const Duration(seconds: 1));
    });
  });
}
