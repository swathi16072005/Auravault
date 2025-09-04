import 'package:flutter/material.dart';
import '../app_state.dart';

class OutageBanner extends StatelessWidget {
  const OutageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    if (!app.outageMode) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: Colors.red.withOpacity(0.12),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.report, color: Colors.red, size: 18),
          SizedBox(width: 8),
          Text('Outage Mode Enabled'),
        ],
      ),
    );
  }
}


