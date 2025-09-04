import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '../app_state.dart';

class GamifiedHeader extends StatelessWidget {
  const GamifiedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _AnimatedShield(score: app.trustScore),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Trust Score', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 8),
                      Tooltip(message: 'Earn points by generating proofs and verifying', child: Icon(Icons.info_outline, size: 16, color: cs.outline)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: app.trustScore / 100.0,
                      backgroundColor: cs.surfaceContainerHighest,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('Streak: ${app.streakDays} days · Badges: ${app.badges.length}', style: TextStyle(color: cs.outline)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedShield extends StatelessWidget {
  final int score;
  const _AnimatedShield({required this.score});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation, secondaryAnimation) => SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled,
        child: child,
      ),
      child: CircleAvatar(
        key: ValueKey(score),
        radius: 28,
        backgroundColor: score >= 70 ? const Color(0xFF75E0A3).withOpacity(0.2) : cs.primaryContainer,
        child: Icon(Icons.shield_rounded, color: score >= 70 ? const Color(0xFF2FB26E) : cs.onPrimaryContainer),
      ),
    );
  }
}


