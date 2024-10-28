import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../features/hilo/presentation/hilo_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/notificaciones/presentation/screens/notificaciones_screen.dart';
import '../features/postear_hilo/presentation/postear_hilo_screen.dart';

GoRouter routes = GoRouter(
  navigatorKey: Get.key,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/hilo/:id",
      builder: (context, state) => HiloScreen(id: state.pathParameters["id"]!),
    ),
    GoRoute(
      path: "/postear-hilo",
      builder: (context, state) => const PostearHiloScreen(),
    ),
    GoRoute(
      path: "/mis-notificaciones",
      builder: (context, state) => const NotificacionesScreen(),
    ),
    GoRoute(
      path: "/postear-hilo",
      builder: (context, state) => const PostearHiloScreen(),
    ),
  ],
);
