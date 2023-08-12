import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  List<String> emulatorsMap = [
    'iPhone 13 Pro',
    'iPad Pro (12.9-inch) (6th generation)',
    'Pixel_6_API_33_1',
    'Nexus_S_API_33_1',
  ];

  print('Setting up directories');

  setupDirectories();

  print('Running screenshots process');
  await runFlutterScreenshotTests(emulatorsMap);
}

void setupDirectories() {
  List<String> platforms = ['android', 'ios'];

  for (final platform in platforms) {
    final dir = Directory('screenshots/$platform');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }
}

Future<void> runFlutterIntegrationTests(
    String deviceId, String deviceName, DevicePlatform platform) async {
  const String integrationTestDriver = 'test_driver/integration_test.dart';
  const String integrationTestTarget = 'integration_test/main_test.dart';

  String platformName;
  switch (platform) {
    case DevicePlatform.ios:
      platformName = 'ios';
      break;
    case DevicePlatform.android:
      platformName = 'android';
      break;
    default:
      platformName = 'android';
  }

  print('Running flutter drive');
  final result = await Process.run('flutter', [
    'drive',
    '-d',
    deviceId,
    '--dart-define',
    'DEVICE_NAME=$deviceName',
    '--dart-define',
    'PLATFORM=$platformName',
    '--driver=$integrationTestDriver',
    '--target=$integrationTestTarget',
  ]);
  print(result.stdout);
  print(result.stderr);
}

Future<void> runFlutterScreenshotTests(List<String> emulatorIDs) async {
  final emulators = await Emulators.build();

  // Shutdown all the running emulators
  await emulators.shutdownAll();

  final configs = [
    {'locale': 'en-US'},
  ];
  await emulators.forEach(emulatorIDs)((device) async {
    for (final _ in configs) {
      DeviceState state = device.state;
      String deviceName = state.name;
      String deviceId = state.id;
      DevicePlatform platform = state.platform;
      print('Running emulator for ${deviceName}');
      await runFlutterIntegrationTests(deviceId, deviceName, platform);
    }
  });
}
