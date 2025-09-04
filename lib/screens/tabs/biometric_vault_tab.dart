import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../../app_state.dart';

class BiometricVaultTab extends StatefulWidget {
  const BiometricVaultTab({super.key});

  @override
  State<BiometricVaultTab> createState() => _BiometricVaultTabState();
}

class _BiometricVaultTabState extends State<BiometricVaultTab> {
  bool enrolled = false;
  bool? verifyOk;

  void enroll() {
    setState(() {
      enrolled = true;
      verifyOk = null;
    });
    try {
      AppStateScope.of(context).awardTrustPoints(8, badge: 'Biometric Enrolled');
      AppStateScope.of(context).markDailyUse();
    } catch (_) {}
  }

  void verify(bool ok) {
    setState(() {
      verifyOk = ok;
    });
    try {
      AppStateScope.of(context).awardTrustPoints(ok ? 10 : 0, badge: ok ? 'Biometric Verified' : null);
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
          Text('Biometric Vault', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: enroll,
                  icon: const Icon(Icons.fingerprint_rounded),
                  label: const Text('Enroll Biometric'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  onPressed: enrolled ? () => verify(true) : null,
                  icon: const Icon(Icons.verified_user_rounded),
                  label: const Text('Verify (YES)'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: enrolled ? () => verify(false) : null,
                  icon: const Icon(Icons.report_gmailerrorred_rounded),
                  label: const Text('Verify (NO)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !enrolled
                ? Container(
                    key: const ValueKey('not_enrolled'),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: cs.surfaceContainerHighest, borderRadius: BorderRadius.circular(16)),
                    child: const Text('Enroll to split fingerprint into 3 shards.'),
                  )
                : _ShardsView(key: const ValueKey('shards')),
          ),
          const SizedBox(height: 16),
          if (verifyOk != null)
            PageTransitionSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation, secondaryAnimation) => SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.vertical,
                child: child,
              ),
              child: Card(
                key: ValueKey(verifyOk),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(verifyOk! ? Icons.verified_rounded : Icons.cancel_rounded,
                          color: verifyOk! ? const Color(0xFF75E0A3) : Colors.red),
                      const SizedBox(width: 12),
                      Text(verifyOk! ? 'Biometric Verified' : 'Biometric Failed'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ShardsView extends StatelessWidget {
  const _ShardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final shardIcons = [Icons.fingerprint, Icons.fingerprint, Icons.fingerprint];
    final labels = ['Shard 1', 'Shard 2', 'Shard 3'];
    final colors = [Colors.blue[100], Colors.green[100], Colors.purple[100]];
    return Row(
      children: List.generate(3, (i) {
        return Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(shardIcons[i], size: 48),
                  const SizedBox(height: 8),
                  Text(labels[i]),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}


