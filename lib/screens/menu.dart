import 'package:flutter/material.dart';
import 'package:scorescribe/screens/about.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          key: const ValueKey('about'),
          leading: const Icon(Icons.info_outline),
          title: const Text("About"),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const AboutScreen(),
            );
          },
        ),
      ],
    );
  }
}
