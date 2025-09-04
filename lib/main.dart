import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_state.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  runApp(const AuraVaultApp());
}

class AuraVaultApp extends StatefulWidget {
  const AuraVaultApp({super.key});

  @override
  State<AuraVaultApp> createState() => _AuraVaultAppState();
}

class _AuraVaultAppState extends State<AuraVaultApp> {
  late final AppState _appState;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _router = createRouter(_appState);
  }

  @override
  Widget build(BuildContext context) {
    final light = buildLightTheme(GoogleFonts.manropeTextTheme());
    final dark = buildDarkTheme(GoogleFonts.manropeTextTheme());

    return AppStateScope(
      appState: _appState,
      child: MaterialApp.router(
        title: 'Auravault',
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        theme: light,
        darkTheme: dark,
        themeMode: _appState.themeMode,
      ),
    );
  }
}
