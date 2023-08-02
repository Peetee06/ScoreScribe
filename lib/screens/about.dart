import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
    const String website = "github.com";
    const String email = "contact@example.com";

    return FutureBuilder(
      future: updateMetaData(),
      builder: (context, snapshot) => snapshot.hasData
          ? Center(
              child: AboutDialog(
                applicationIcon: Image.asset(
                  "assets/app_icon.png",
                  width: 64,
                  height: 64,
                ),
                applicationName: snapshot.data!["appName"],
                applicationVersion: "v${snapshot.data!["version"]}",
                children: [
                  const Text(
                      "Spielblock is a free and open source app for tracking game scores with friends."),
                  const Text(""),
                  Row(
                    children: [
                      const Text("Website: "),
                      GestureDetector(
                        child: const Text(
                          "github.com",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () async {
                          Uri url = Uri(
                              scheme: "https",
                              host: website,
                              pathSegments: ["Peetee06", "spielblock"]);
                          final BuildContext contextBeforeGap = context;
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            Clipboard.setData(
                                ClipboardData(text: url.toString()));
                            ScaffoldMessenger.of(contextBeforeGap).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Unable to open website.\nWebsite URL was copied to clipboard instead.'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const Text(""),
                  Row(
                    children: [
                      const Text("Contact: "),
                      GestureDetector(
                        child: const Text(
                          email,
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () async {
                          Uri url = Uri(
                            scheme: 'mailto',
                            path: email,
                          );
                          final BuildContext contextBeforeGap = context;
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            Clipboard.setData(
                                ClipboardData(text: url.toString()));
                            ScaffoldMessenger.of(contextBeforeGap).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Unable to open mail app.\nEmail address was copied to clipboard instead.'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
