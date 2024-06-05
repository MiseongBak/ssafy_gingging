import 'package:flutter/material.dart';
import 'package:frontend/router/router_path.dart';
import 'package:frontend/screens/campaign/campaign_screen.dart';
import 'package:frontend/screens/history/history_screen.dart';
import 'package:frontend/screens/intro/intro_screen.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/member/login_screen.dart';
import 'package:frontend/screens/member/signup_screen.dart';
import 'package:frontend/screens/plogging/progressplogging/no_device_plogging.dart';
import 'package:frontend/screens/plogging/progressplogging/progress_plogging.dart';
import 'package:frontend/screens/plogging/readyplogging/ready_plogging.dart';
import 'package:frontend/screens/profile/profile_screen.dart';
import 'package:frontend/screens/ranking/ranking_screen.dart';
import 'package:frontend/screens/rescue/rescue_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter globalRouter = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.signUp,
      name: 'signUp',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.intro,
      name: 'intro',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const IntroScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const MainScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.ranking,
      name: 'ranking',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RankingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.history,
      name: 'history',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HistoryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.campaign,
      name: 'campaign',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CampaignScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.ploggingReady,
      name: 'ploggingReady',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ReadyPlogging(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.profile,
      name: 'profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.rescue,
      name: 'rescue',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RescueScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.ploggingProgress,
      name: 'ploggingProgress',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProgressPlogging(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: RoutePath.noDevicePlogging,
      name: 'noDevicePlogging',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const NoDevicePlogging(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    // GoRoute(
    //   path: RoutePath.main,
    //   name: 'main',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id'];
    //     final bookId = state.pathParameters['bookId'];
    //     return MainScreen(id: id ?? '0', bookId: bookId ?? '0');
    //   },
    // ),
  ],
  initialLocation: RoutePath.login,
);
