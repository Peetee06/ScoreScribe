import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<Map<String, dynamic>> updateMetaData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return {
      "appName": packageInfo.appName,
      "packageName": packageInfo.packageName,
      "version": packageInfo.version,
      "buildNumber": packageInfo.buildNumber,
    };
  }

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
        body: FutureBuilder(
          future: updateMetaData(),
          builder: (context, snapshot) => Column(
            children: [
              const Text("About page"),
              Text(snapshot.hasData ? snapshot.data!["version"] : "Not loaded"),
            ],
          ),
        ));
  }
}
