import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feature/auth/data/repository/auth_repository.dart';
import '../feature/auth/presentation/bloc/auth_bloc.dart';
import 'router/router.dart';
import 'service/service_locator.dart';
import 'service/supabase_service.dart';
import 'theme/theme.dart';

class AynaApp extends StatelessWidget {
  const AynaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(client: sl<SupabaseService>().client),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepo: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp.router(
          title: 'Ayna App',
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );
  }
}
