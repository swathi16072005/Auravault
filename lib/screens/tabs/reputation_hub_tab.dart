import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReputationHubTab extends StatefulWidget {
  const ReputationHubTab({super.key});

  @override
  State<ReputationHubTab> createState() => _ReputationHubTabState();
}

class _ReputationHubTabState extends State<ReputationHubTab> {
  String? _proof;

  @override
  Widget build(BuildContext context) {
    final badges = ['Loan repaid', 'Aid received', 'Volunteer', 'Tax filed'];
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Reputation Hub', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: badges.map((b) => Chip(avatar: const Icon(Icons.verified, size: 16), label: Text(b))).toList(),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              setState(() => _proof = '{"proof":"3+ attestations"}');
              try {
                AppStateScope.of(context).awardTrustPoints(12, badge: 'Reputation 3+');
                AppStateScope.of(context).markDailyUse();
              } catch (_) {}
            },
            icon: const Icon(Icons.qr_code_2_rounded),
            label: const Text('Generate Reputation Proof'),
          ),
          const SizedBox(height: 20),
          if (_proof != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Reputation Proof', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    QrImageView(data: _proof!, size: 220, backgroundColor: Colors.white),
                    const SizedBox(height: 8),
                    Text(_proof!, style: TextStyle(color: cs.outline)),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}


