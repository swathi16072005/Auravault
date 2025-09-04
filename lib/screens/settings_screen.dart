import 'package:flutter/material.dart';
import '../app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final did = 'did:example:auravault-user';
    final pubKey = 'AVPUBKEY-1234-5678-ABCD';
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle Light/Dark'),
            value: app.themeMode == ThemeMode.dark,
            onChanged: (_) => app.toggleTheme(),
          ),
          SwitchListTile(
            title: const Text('Outage Mode'),
            subtitle: const Text('Show global red banner'),
            value: app.outageMode,
            onChanged: (_) => app.toggleOutageMode(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.ios_share_rounded),
            title: const Text('Export Public Profile'),
            subtitle: const Text('Show mock DID + public key'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Public Profile'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DID: $did'),
                      const SizedBox(height: 8),
                      Text('Public Key: $pubKey'),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


