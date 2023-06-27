import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:mobilequemanagement_frontend/contact_us.dart';
import 'package:mobilequemanagement_frontend/faq.dart';
import 'package:mobilequemanagement_frontend/privacy_policy.dart';
import 'package:mobilequemanagement_frontend/terms_of_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF05046a),
                title: const Text('Settings'),
              ),
              body: SettingsList(
                sections: [
                  SettingsSection(
                    titlePadding: const EdgeInsets.all(20),
                    title: 'General',
                    tiles: [
                      SettingsTile(
                        title: 'Language',
                        subtitle: 'English',
                        leading: const Icon(Icons.language),
                        onPressed: (BuildContext context) {},
                      ),
                      SettingsTile.switchTile(
                        title: 'Use System Theme',
                        leading: const Icon(Icons.phone_android),
                        switchValue: isSwitched,
                        onToggle: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    titlePadding: const EdgeInsets.all(20),
                    title: 'Terms and Conditions',
                    tiles: [
                      SettingsTile(
                        title: 'Terms of Service',
                        leading: const Icon(Icons.description),
                        onPressed: (BuildContext context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TermsOfService()),
                          );
                        },
                      ),
                      SettingsTile(
                        title: 'Privacy Policy',
                        leading: const Icon(Icons.privacy_tip),
                        onPressed: (BuildContext context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivacyPolicy()),
                          );
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    titlePadding: const EdgeInsets.all(20),
                    title: 'Help',
                    tiles: [
                      SettingsTile(
                        title: 'FAQ',
                        leading: const Icon(Icons.question_answer),
                        onPressed: (BuildContext context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FAQPage()),
                          );
                        },
                      ),
                      SettingsTile(
                        title: 'Contact Us',
                        leading: const Icon(Icons.mail),
                        onPressed: (BuildContext context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactUs()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
