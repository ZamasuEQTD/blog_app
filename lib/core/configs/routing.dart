import 'package:blog_app/features/auth/domain/models/usuario.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen.dart';
import 'package:blog_app/features/hilos/presentation/screens/postear_hilo_screen.dart';
import 'package:blog_app/features/home/presentation/screens/home_screen.dart';
import 'package:blog_app/features/notificaciones/presentation/screens/notificaciones_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter routes = GoRouter(
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
    )
  ],
);
