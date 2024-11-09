import 'package:blog_app/src/lib/features/auth/presentation/screens/registro_screen.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/screens/banear_usuario_screen.dart';
import 'package:blog_app/src/lib/features/media/presentation/screens/agregar_enlace_screen.dart';
import 'package:blog_app/src/lib/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/hilo/presentation/hilo_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/notificaciones/presentation/screens/notificaciones_screen.dart';
import '../features/postear_hilo/presentation/postear_hilo_screen.dart';

class Routes {
  static const home = "/";
  static const login = "/login";
  static const registro = "/registro";
  static const hilo = "/hilo/:id";
  static const postear = "/postear-hilo";
  static const notificaciones = "/mis-notificaciones";
  static const banear = "/banear-usuario/:id";
  static const agregarEnlace = "/agregar-enlace";
}

GoRouter routes = GoRouter(
  navigatorKey: Get.key,
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.hilo,
      builder: (context, state) => HiloScreen(id: state.pathParameters["id"]!),
    ),
    GoRoute(
      path: Routes.postear,
      builder: (context, state) => const PostearHiloScreen(),
    ),
    GoRoute(
      path: Routes.notificaciones,
      builder: (context, state) => const NotificacionesScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.registro,
      builder: (context, state) => const RegistroScreen(),
    ),
    GoRoute(
      name: "banear-usuario",
      path: Routes.banear,
      builder: (context, state) => BanearUsuarioScreen(
        id: state.pathParameters["id"]!,
      ),
    ),
    GoRoute(
      path: Routes.agregarEnlace,
      builder: (context, state) => Provider<OnEnlaceAgregado>.value(
        value: state.extra as OnEnlaceAgregado,
        child: const AgregarEnlaceScreen(),
      ),
    ),
  ],
);
