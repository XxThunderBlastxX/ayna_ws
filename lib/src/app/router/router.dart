import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/presentation/screens/screens.dart';
import '../service/service_locator.dart';
import '../service/supabase_service.dart';

GoRouter router = GoRouter(
  initialLocation: sl<SupabaseService>().client.auth.currentSession != null
      ? "/home"
      : "/auth",
  routes: [
    GoRoute(
      path: "/auth",
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const AuthScreen(),
      ),
    ),
    GoRoute(
      path: "/auth/signup",
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SignupScreen(),
      ),
    ),
    GoRoute(
      path: "/auth/login",
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
  ],
);
