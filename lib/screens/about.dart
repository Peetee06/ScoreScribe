import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow,
      ),
      body: const Center(
        child: Text("About page"),
      ),
    );
  }
}
