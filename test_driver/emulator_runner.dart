import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  List<String> emulatorsMap = [
    'iPhone 13 Pro',
    'iPad Pro (12.9-inch) (6th generation)',
    'Pixel_6_API_33_1',
    // 'Nexus_S_API_33_1',
  ];
  print('Running process');
  await runFlutterScreenshotTests(emulatorsMap);
}

void setupDirectories(String platform, String deviceName) {
  final dir = Directory('screenshots/$platform/$deviceName');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
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

  print('Setting up directories');
  setupDirectories(platformName, deviceName);

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

Future<void> runFlutterScreenshotTests(List<String> emulatorMap) async {
  final emulators = await Emulators.build();

  // Shutdown all the running emulators
  await emulators.shutdownAll();

  print('Emulators: $emulators');
  final configs = [
    {'locale': 'en-US'},
  ];
  print('Running forEach');
  await emulators.forEach(emulatorMap)((device) async {
    print('running device $device');
    for (final _ in configs) {
      DeviceState state = device.state;
      print('Running emulator ${state.name} with id ${state.id}');
      await runFlutterIntegrationTests(state.id, state.name, state.platform);
    }
  });
}
