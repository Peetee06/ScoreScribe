import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  List<String> emulatorsMap = [
    'iPhone 13 Pro',
    'iPad Pro (12.9-inch) (6th generation)',
    'Pixel_6_API_33_1',
    'Nexus_S_API_33_1',
  ];

  await runFlutterScreenshotTests(emulatorsMap);
}

Future<void> runFlutterScreenshotTests(List<String> emulatorIDs) async {
  // Build the emulators
  final emulators = await Emulators.build();

  // Shutdown all the running emulators
  await emulators.shutdownAll();

  // Setup localization configuration
  final configs = [
    {'locale': 'en-US'},
  ];

  // Run screenshots routine for each emulator
  await emulators.forEach(emulatorIDs)((device) async {
    for (final _ in configs) {
      final p = await emulators
          .drive(device, 'test_driver/emulators/screenshot.dart', config: _);
      stderr.addStream(p.stderr);
      await stdout.addStream(p.stdout);
    }
  });
}
