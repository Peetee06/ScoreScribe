import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorecard/screens/tabs.dart';
import 'color_schemes.g.dart';

void main() {
  const deviceName = String.fromEnvironment('DEVICE_NAME');
  print("Device name in main.dart $deviceName");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.system,
      home: const Tabs(),
      debugShowCheckedModeBanner: true,
    );
  }
}
