import 'package:ayna_ws_assignment/src/app/error/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widget/styled_form_field.dart';
import '../../../../app/theme/theme.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go("/home");
        } else if (state is AuthFailure) {
          context.errorBanner(
            state.failure.message,
            statusCode: state.failure.code,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: AppTheme.theme.textTheme.displayLarge,
                ),
                const Gap(24),
                Form(
                  child: Column(
                    children: [
                      StyledFormField(
                        label: 'Email',
                        icon: const Icon(Icons.email),
                        controller: _emailController,
                      ),
                      const Gap(18),
                      StyledFormField(
                        label: 'Password',
                        icon: const Icon(Icons.lock),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const Gap(28),
                      (state is AuthLoading)
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                      SignInEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Login',
                                  style: AppTheme.theme.textTheme.labelMedium,
                                ),
                              ),
                            ),
                      TextButton(
                        onPressed: () => context.push('/signup'),
                        child: Text(
                          'Don\'t have an account? Sign up',
                          style: AppTheme.theme.textTheme.labelSmall,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
