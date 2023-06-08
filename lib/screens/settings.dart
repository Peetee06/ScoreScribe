import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SeccingsScreenState();
}

class _SeccingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings'),
    );
  }
}
