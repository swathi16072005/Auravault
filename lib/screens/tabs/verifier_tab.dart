import 'dart:convert';
import 'package:flutter/material.dart';
import '../../app_state.dart';

class VerifierTab extends StatefulWidget {
  const VerifierTab({super.key});

  @override
  State<VerifierTab> createState() => _VerifierTabState();
}

class _VerifierTabState extends State<VerifierTab> {
  String? result;
  bool? ok;

  void _scanMock() {
    // Simulate a QR scan by decoding a selected dummy JSON.
    const samples = [
      '{"proof":"age>=18"}',
      '{"proof":"3+ attestations"}',
      '{"proof":"citizenship=true"}',
      '{"bad":"data"}',
    ];
    samples.shuffle();
    final data = samples.first;
    try {
      final decoded = jsonDecode(data) as Map<String, dynamic>;
      final success = decoded.containsKey('proof');
      setState(() {
        result = data;
        ok = success;
      });
      try {
        if (success) {
          AppStateScope.of(context).awardTrustPoints(15, badge: 'Verifier ✅');
          AppStateScope.of(context).markDailyUse();
        }
      } catch (_) {}
    } catch (_) {
      setState(() {
        result = data;
        ok = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Verifier', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _scanMock,
            icon: const Icon(Icons.qr_code_scanner_rounded),
            label: const Text('Scan Proof'),
          ),
          const SizedBox(height: 16),
          if (ok != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(ok! ? Icons.verified_rounded : Icons.cancel_rounded,
                        color: ok! ? const Color(0xFF75E0A3) : Colors.red),
                    const SizedBox(width: 12),
                    Expanded(child: Text(ok! ? 'Valid proof' : 'Invalid proof')),
                  ],
                ),
              ),
            ),
          if (result != null) ...[
            const SizedBox(height: 8),
            Text('Decoded: $result', style: TextStyle(color: cs.outline)),
          ]
        ],
      ),
    );
  }
}


