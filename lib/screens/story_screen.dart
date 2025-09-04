import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_state.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  int index = 0;

  List<_StoryStep> get steps => [
        _StoryStep(
          title: 'National ID System: DOWN',
          description: 'Centralized systems fail. Citizens need resilient identity.',
          color: Colors.red,
          icon: Icons.warning_rounded,
        ),
        const _StoryStep(
          title: 'User opens Auravault',
          description: 'Self-sovereign ID wallet boots instantly, offline-ready.',
          color: null,
          icon: Icons.lock_open_rounded,
        ),
        const _StoryStep(
          title: 'Generates proof → QR shown',
          description: 'Zero-knowledge style proof rendered as QR. No internet needed.',
          color: null,
          icon: Icons.qr_code_rounded,
        ),
        const _StoryStep(
          title: 'Verifier scans QR offline → Green Shield ✅',
          description: 'Trust established locally. Services continue.',
          color: null,
          icon: Icons.verified_rounded,
        ),
      ];

  void next() {
    if (index < steps.length - 1) {
      setState(() => index++);
    } else {
      context.go('/home');
    }
  }

  void showJudgeMode() {
    showModal(
      context: context,
      builder: (context) => const _JudgeModeCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final current = steps[index];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auravault Story'),
        bottom: appState.outageMode
            ? PreferredSize(
                preferredSize: const Size.fromHeight(36),
                child: Container(
                  width: double.infinity,
                  color: Colors.red.withOpacity(0.15),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.report_gmailerrorred, color: Colors.red, size: 18),
                      SizedBox(width: 8),
                      Text('Outage Mode Enabled'),
                    ],
                  ),
                ),
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showJudgeMode,
        icon: const Icon(Icons.school_rounded),
        label: const Text('Judge Mode'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primary.withOpacity(0.08), cs.surface],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: current.color?.withOpacity(0.12) ?? cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(current.icon, color: current.color ?? cs.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(current.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(current.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 350),
                  reverse: false,
                  transitionBuilder: (child, animation, secondaryAnimation) => SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  ),
                  child: _StoryCard(step: current, key: ValueKey(index)),
                ),
              ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, child) => Transform.scale(scale: 0.98 + value * 0.02, child: child),
                child: FilledButton.icon(
                  onPressed: () {
                    AppStateScope.of(context).awardTrustPoints(5);
                    next();
                  },
                  icon: Icon(index == steps.length - 1 ? Icons.arrow_forward_rounded : Icons.play_arrow_rounded),
                  label: Text(index == steps.length - 1 ? 'Go to App' : 'Next'),
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final _StoryStep step;
  const _StoryCard({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: cs.primaryContainer, child: Icon(step.icon, color: cs.onPrimaryContainer)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(step.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(step.description),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.swipe_right_alt_rounded, color: cs.outline),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryStep {
  final String title;
  final String description;
  final Color? color;
  final IconData icon;
  const _StoryStep({required this.title, required this.description, required this.color, required this.icon});
}

class _JudgeModeCard extends StatelessWidget {
  const _JudgeModeCard();

  @override
  Widget build(BuildContext context) {
    final points = [
      'Zero-Knowledge Proofs (simulated) → Prove without exposing data.',
      'Offline Mode → QR works even without internet.',
      'Emergency Fallback ID → temporary rescue proof.',
      'Multi-device recovery → simulated key restore.',
      'Blockchain Trust Layer → animated "ledger log" icon.',
      'Modular & interoperable → bank, hospital, gov icons.',
      'Voice-based ID → mic icon, disabled for now.',
      'Smart City ready → transport + e-health icons.',
      'User sovereignty → "You own your ID" badge.',
      'Multi-layer security → Biometric + QR + Ledger icons.',
      'Global potential → globe icon.',
      'Gamified verification → Green shield, trust badges.',
    ];
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.school_rounded),
                SizedBox(width: 8),
                Text('Judge Mode'),
              ],
            ),
            const SizedBox(height: 12),
            ...points.map((p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(children: [const Icon(Icons.check_circle, color: Color(0xFF75E0A3)), const SizedBox(width: 8), Expanded(child: Text(p))]),
                )),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
            )
          ],
        ),
      ),
    );
  }
}


