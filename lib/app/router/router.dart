import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/Root/components/Tab/tab_shell.dart';
import 'package:image_search/app/screen/Root/root_page.dart';

abstract class RouterOutlet {
  // static final RouterOutlet _instance = RouterOutlet._internal();

  // factory RouterOutlet() {
  //   return _instance;
  // }

  // RouterOutlet._internal();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Route.root,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(path: Route.root, builder: (context, state) => RootPage()),
      StatefulShellRoute.indexedStack(builder: (context, state, child) => TabShell(navigationShell: child,),
      branches: []),
    ],
  );
}

abstract class Route {
  static const root = _Path.root;
}

abstract class _Path {
  static const root = '/';
}
