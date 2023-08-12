import 'package:emulators/emulators.dart';

Future<void> main() async {
  List<String> emulatorIds = [
    'Pixel_6_API_33_1',
    // 'iPhone 14 Pro',
  ];
  print('Running process');
  await runFlutterScreenshotTests(emulatorIds);
}

Future<void> runFlutterScreenshotTests(List<String> emulatorIds) async {
  final emulators = await Emulators.build();

  // Shutdown all the running emulators
  await emulators.shutdownAll();

  print('Emulators: $emulators');
  final configs = [
    {'locale': 'en-US'},
  ];
  print('Running forEach');
  await emulators.forEach(emulatorIds)((device) async {
    print('running device $device');
    for (final _ in configs) {
      DeviceState state = device.state;
      print('Running emulator ${state.name} with id ${state.id}');
    }
  });
}
