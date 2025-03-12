import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/favorite_page.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/image_search_page.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/pages/detail/image_search_detail.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/text_search_page.dart';
import 'package:image_search/app/screen/Tab/tab_shell.dart';

abstract class RouterOutlet {
  // static final RouterOutlet _instance = RouterOutlet._internal();

  // factory RouterOutlet() {
  //   return _instance;
  // }

  // RouterOutlet._internal();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  // static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: RouterPath.image,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, child) => TabShell(navigationShell: child),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.image,
                builder: (context, state) => ImageSearchPage(),
                routes: [
                  GoRoute(
                    path: '${_Path.detail}/:${_Param.id}',
                    builder: (context, state) => ImageSearchDetail(state.pathParameters[_Param.id]),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(routes: [GoRoute(path: _Path.text, builder: (context, state) => TextSearchPage())]),
          StatefulShellBranch(routes: [GoRoute(path: _Path.favorite, builder: (context, state) => FavoritePage())]),
        ],
      ),
    ],
  );
}

abstract class RouterPath {
  static const root = _Path.root;
  static const favorite = _Path.favorite;
  static const image = _Path.image;
  static String imageDetail(int id) => '$image${_Path.detail}/$id';
  static const text = _Path.text;
}

abstract class _Path {
  static const root = '/';
  static const favorite = '/favorite';
  static const image = '/image';
  static const text = '/text';

  static const detail = '/detail';
}

abstract class _Param {
  static const id = 'id';
}
