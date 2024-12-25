import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:blog_app/features/auth/presentation/screens/registro_screen.dart';
import 'package:blog_app/features/baneos/presentation/screens/banear_usuario_screen.dart';
import 'package:blog_app/features/colecciones/presentation/logic/controllers/coleccion_controller.dart';
import 'package:blog_app/features/colecciones/presentation/screens/coleccion_screen.dart';
import 'package:blog_app/features/colecciones/presentation/screens/hilo_por_categoria_screen.dart';
import 'package:blog_app/features/colecciones/presentation/screens/hilos_por_titulo_screen.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/hilo_screen.dart';
import 'package:blog_app/features/home/presentation/screens/home_screen.dart';
import 'package:blog_app/features/notificaciones/presentation/screens/notificaciones_screen.dart';
import 'package:blog_app/features/postear_hilo/presentation/screens/postear_hilo_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const home = "/";
  static const login = "/login";
  static const registro = "/registro";
  static const hilo = "/hilo/:id";
  static const postear = "/postear-hilo";
  static const notificaciones = "/mis-notificaciones";
  static const banear = "/banear-usuario/:id";
  static const agregarEnlace = "/agregar-enlace";
  static const misHilos = "/mis-hilos";
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
      path: "/portadas/categoria/:categoria",
      builder: (context, state) {
        return PortadasPorCategoriaScreen(
          subcategoria: state.pathParameters["categoria"]!,
        );
      },
    ),
    GoRoute(
      path: "/portadas/titulo",
      builder: (context, state) => const PortadasPorTituloScreen(),
    ),
    GoRoute(
      path: "/colecciones/:coleccion",
      builder: (context, state) => ColeccionScreen(
        coleccion: Coleccion.values
            .firstWhere((e) => e.name == state.pathParameters["coleccion"]),
      ),
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
      name: "banear-usuario/:id",
      path: Routes.banear,
      builder: (context, state) => BanearUsuarioScreen(
        id: state.pathParameters["id"]!,
      ),
    ),
  ],
);

class HubRoutes {
  static const String home = "Home";
  static const String hilo = "hilo/";
}
