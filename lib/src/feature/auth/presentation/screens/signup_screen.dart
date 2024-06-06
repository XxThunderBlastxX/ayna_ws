import 'package:ayna_ws_assignment/src/app/error/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/common/widget/styled_form_field.dart';
import '../../../../app/theme/theme.dart';
import '../bloc/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _rewritePasswordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _rewritePasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rewritePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/home');
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
                  'Create an Account',
                  style: AppTheme.theme.textTheme.displayLarge,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Gap(24),
                      StyledFormField(
                        label: 'Username',
                        icon: const Icon(Icons.person),
                        controller: _usernameController,
                      ),
                      const Gap(12),
                      StyledFormField(
                        label: 'Email',
                        icon: const Icon(Icons.email),
                        controller: _emailController,
                      ),
                      const Gap(12),
                      StyledFormField(
                        label: 'Password',
                        icon: const Icon(Icons.lock),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const Gap(12),
                      StyledFormField(
                        label: 'Rewrite Password',
                        icon: const Icon(Icons.lock),
                        controller: _rewritePasswordController,
                        obscureText: true,
                        validator: (val) {
                          if (val != _passwordController.text) {
                            return 'Enter the same password as above';
                          }
                          return null;
                        },
                      ),
                      const Gap(24),
                      (state is AuthLoading)
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () => onSubmit(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Signup',
                                  style: AppTheme.theme.textTheme.labelMedium,
                                ),
                              ),
                            ),
                      const Gap(8),
                      TextButton(
                        onPressed: () => context.pushReplacement('/login'),
                        child: Text(
                          'Already have an account? Login',
                          style: AppTheme.theme.textTheme.labelSmall,
                        ),
                      ),
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

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignUpEvent(
              username: _usernameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
