import 'package:flutter/material.dart';
import '../widgets/outage_banner.dart';
import '../widgets/gamified_header.dart';
import 'tabs/identity_vault_tab.dart';
import 'tabs/reputation_hub_tab.dart';
import 'tabs/biometric_vault_tab.dart';
import 'tabs/verifier_tab.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final _tabs = const [
    IdentityVaultTab(),
    ReputationHubTab(),
    BiometricVaultTab(),
    VerifierTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auravault')),
      body: Column(
        children: [
          const OutageBanner(),
          const GamifiedHeader(),
          Expanded(child: _tabs[_index]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.badge_rounded), label: 'Identity'),
          NavigationDestination(icon: Icon(Icons.emoji_events_rounded), label: 'Reputation'),
          NavigationDestination(icon: Icon(Icons.fingerprint_rounded), label: 'Biometric'),
          NavigationDestination(icon: Icon(Icons.verified_rounded), label: 'Verifier'),
        ],
      ),
    );
  }
}


