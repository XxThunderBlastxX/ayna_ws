import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class AynaApp extends StatelessWidget {
  const AynaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ayna App',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
