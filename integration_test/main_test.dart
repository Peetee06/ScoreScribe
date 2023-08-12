import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:scorecard/main.dart' as app;

import 'page_objects/tabs_screen.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const deviceName = String.fromEnvironment('DEVICE_NAME');
  const platform = String.fromEnvironment('PLATFORM');

  String devicePrefix = deviceName.isEmpty ? '' : deviceName;
  String screenshotDirectory = 'screenshots/$platform/${devicePrefix}_';
  print("Device name in menu_test $deviceName");
  print("Screenshots directory in menu_test $screenshotDirectory");

  group('end-to-end-test', () {
    testWidgets('render games and navigate to menu', (tester) async {
      // Build the app.
      app.main();

      print('running tests');
      if (Platform.isAndroid) {
        await binding.convertFlutterSurfaceToImage();
      }

      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump();
      print('creating first screenshot');

      await binding.takeScreenshot('${screenshotDirectory}screenshot-1');

      TabsTestScreen tabsTestScreen = TabsTestScreen(tester);
      await tester.pump();

      await expectLater(tabsTestScreen.isReady(), completion(true));
      await tabsTestScreen.tapMenuTab();
      await tester.pumpAndSettle();

      print('Creating second screenshot');

      expect(find.text('About'), findsOneWidget);
      await binding.takeScreenshot('${screenshotDirectory}screenshot-4');
    });
  });
}
