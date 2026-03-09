import 'package:fintech_app/core/navigation/app_routes.dart';
import 'package:fintech_app/core/resources/app_images_assets.dart';
import 'package:fintech_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fintech_app/features/view/splash_screens/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  bool _minDelayDone = false;
  bool _authResolved = false;
  AuthStatus _resolvedStatus = AuthStatus.initial;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthCheckRequested());

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _minDelayDone = true;
      _tryNavigate();
    });
  }

  void _tryNavigate() {
    if (!_minDelayDone || !_authResolved) return;
    if (!mounted) return;

    if (_resolvedStatus == AuthStatus.authenticated) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated ||
            state.status == AuthStatus.unauthenticated ||
            state.status == AuthStatus.failure) {
          _authResolved = true;
          _resolvedStatus = state.status;
          _tryNavigate();
        }
      },
      child: Background(
        child: Center(child: Image.asset(PngImages.logoquikpay)),
      ),
    );
  }
}
