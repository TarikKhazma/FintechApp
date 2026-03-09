import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/create_account_success_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/view/onborading/screens/onboarding_main.dart';
import '../../features/view/splash_screens/splash_screens.dart';
import 'app_routes.dart';

/// Auth guard — called on every navigation event.
/// Redirects unauthenticated users away from protected routes.
String? _authGuard(BuildContext context, GoRouterState state) {
  final authStatus = context.read<AuthBloc>().state.status;
  final location = state.matchedLocation;

  // Always allow splash & onboarding — they handle their own navigation
  if (location == AppRoutes.splash || location == AppRoutes.onboarding) {
    return null;
  }

  // While auth check hasn't resolved yet, stay where we are
  if (authStatus == AuthStatus.initial || authStatus == AuthStatus.loading) {
    return null;
  }

  final isAuthenticated = authStatus == AuthStatus.authenticated;
  final isAuthRoute = location.startsWith('/auth');

  if (!isAuthenticated && !isAuthRoute) return AppRoutes.signIn;
  if (isAuthenticated && isAuthRoute) return AppRoutes.home;
  return null;
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  redirect: _authGuard,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (ctx, s) => const SplashScreens(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (ctx, s) => const OnboardingMain(),
    ),

    // ── Auth routes ──────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.signIn,
      builder: (ctx, s) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (ctx, s) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.signUpSuccess,
      builder: (ctx, s) => const CreateAccountSuccessPage(),
    ),

    // ── Protected routes ─────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.home,
      builder: (ctx, s) => const DashboardPage(),
    ),
    GoRoute(
      path: AppRoutes.transactions,
      builder: (ctx, s) => const Scaffold(
        body: Center(child: Text('Transactions — coming soon')),
      ),
    ),
    GoRoute(
      path: AppRoutes.wallet,
      builder: (ctx, s) => const Scaffold(
        body: Center(child: Text('Wallet — coming soon')),
      ),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (ctx, s) => const Scaffold(
        body: Center(child: Text('Profile — coming soon')),
      ),
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
);
