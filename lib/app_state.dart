import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _outageMode = false;
  int _trustScore = 0; // 0-100
  int _streakDays = 0;
  final Set<String> _badges = <String>{};

  ThemeMode get themeMode => _themeMode;
  bool get outageMode => _outageMode;
  int get trustScore => _trustScore;
  int get streakDays => _streakDays;
  Set<String> get badges => _badges;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleOutageMode() {
    _outageMode = !_outageMode;
    notifyListeners();
  }

  // Gamification actions
  void awardTrustPoints(int points, {String? badge}) {
    _trustScore = (_trustScore + points).clamp(0, 100);
    if (badge != null) {
      _badges.add(badge);
    }
    notifyListeners();
  }

  void markDailyUse() {
    _streakDays = (_streakDays + 1).clamp(0, 3650);
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({super.key, required AppState appState, required Widget child})
      : super(notifier: appState, child: child);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in context');
    return scope!.notifier!;
  }
}


