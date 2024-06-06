import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late Image homeImage;

  @override
  void initState() {
    super.initState();
    homeImage = Image.asset('assets/images/chat.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(homeImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeImage,
            const Gap(28),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chatting App',
                style: AppTheme.theme.textTheme.displayLarge,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'An easy way to chat with your friends and family.',
                style: AppTheme.theme.textTheme.labelSmall!.copyWith(
                  color: Colors.black38,
                ),
              ),
            ),
            const Gap(28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.push('/auth/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'LOGIN',
                  style: AppTheme.theme.textTheme.labelMedium,
                ),
              ),
            ),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/auth/signup'),
                child: Text(
                  'SIGN UP',
                  style: AppTheme.theme.textTheme.labelMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
