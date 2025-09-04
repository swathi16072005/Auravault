import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IdentityVaultTab extends StatefulWidget {
  const IdentityVaultTab({super.key});

  @override
  State<IdentityVaultTab> createState() => _IdentityVaultTabState();
}

class _IdentityVaultTabState extends State<IdentityVaultTab> {
  String? _proofJson;

  void _generateProof(String type) {
    setState(() {
      _proofJson = '{"proof":"$type"}';
    });
    // Award points and badge
    try {
      AppStateScope.of(context).awardTrustPoints(10, badge: 'Proof: $type');
      AppStateScope.of(context).markDailyUse();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Identity Vault', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text('Age 18+')),
              Chip(label: Text('Citizen')),
              Chip(label: Text('Resident')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _generateProof('age>=18'),
                  icon: const Icon(Icons.cake_rounded),
                  label: const Text('Age Proof'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _generateProof('citizenship=true'),
                  icon: const Icon(Icons.flag_rounded),
                  label: const Text('Citizenship'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_proofJson != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Generated Proof', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    QrImageView(data: _proofJson!, size: 220, backgroundColor: Colors.white),
                    const SizedBox(height: 8),
                    Text(_proofJson!, style: TextStyle(color: cs.outline)),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(16)),
              child: const Text('Generate a proof to display a QR code.'),
            ),
        ],
      ),
    );
  }
}


