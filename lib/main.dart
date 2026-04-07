import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'config/app_theme.dart';
import 'pages/home_page.dart';
import 'pages/tour_detail_page.dart';
import 'pages/contact_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(const CapeBestToursApp());
}

class CapeBestToursApp extends StatelessWidget {
  const CapeBestToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/tours/:slug',
          builder: (context, state) {
            final slug = state.pathParameters['slug']!;
            return TourDetailPage(slug: slug);
          },
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Cape Best Tours',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
