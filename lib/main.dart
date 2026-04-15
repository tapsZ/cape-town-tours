import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/services/api_service.dart';
import 'logic/cape_tours_cubit.dart';
import 'logic/cape_tours_state.dart';
import 'config/app_theme.dart';
import 'pages/home_page.dart';
import 'pages/tour_detail_page.dart';
import 'pages/contact_page.dart';
import 'pages/guides_page.dart';
import 'pages/maintenance_page.dart';

void main() {
  setPathUrlStrategy();
  runApp(const CapeBestToursApp());
}

class CapeBestToursApp extends StatelessWidget {
  const CapeBestToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CapeToursCubit(ApiService())..loadData(),
        ),
      ],
      child: const AppLifecycleManager(child: AppWrapper()),
    );
  }
}

class AppLifecycleManager extends StatefulWidget {
  final Widget child;
  const AppLifecycleManager({super.key, required this.child});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<CapeToursCubit>().loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CapeToursCubit, CapeToursState>(
      builder: (context, state) {
        if (state is CapeToursLoading) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
            debugShowCheckedModeBanner: false,
          );
        }

        if (state is CapeToursLoaded) {
          final settings = state.settings;
          final isMaintenance = settings['MAINTENANCE_MODE'] == 'true';
          final isComingSoon = settings['COMING_SOON_MODE'] == 'true';

          if (isMaintenance) {
            return const MaterialApp(
              home: MaintenancePage(),
              debugShowCheckedModeBanner: false,
            );
          }

          if (isComingSoon) {
            return const MaterialApp(
              home: HomePage(), // HomePage contains the "Coming Soon" CTA
              debugShowCheckedModeBanner: false,
            );
          }
        }

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
              path: '/guides',
              builder: (context, state) => const GuidesPage(),
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
      },
    );
  }
}
