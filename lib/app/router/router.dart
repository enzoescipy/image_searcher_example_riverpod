import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/favorite_page.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/pages/ImageDetail/favorite_image_detail.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/pages/TextDetail/favorite_text_detail.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/image_search_page.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/pages/detail/image_search_detail.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/pages/detail/text_search_detail.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/text_search_page.dart';
import 'package:image_search/app/screen/Tab/tab_shell.dart';

abstract class RouterOutlet {
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.text,
                builder: (context, state) => TextSearchPage(),
                routes: [
                  GoRoute(
                    path: '${_Path.detail}/:${_Param.id}',
                    builder: (context, state) => TextSearchDetail(state.pathParameters[_Param.id]),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.favorite,
                builder: (context, state) => FavoritePage(),
                routes: [
                  GoRoute(
                    path: '${_Path.image}${_Path.detail}/:${_Param.id}',
                    builder: (context, state) => FavoriteImageDetail(state.pathParameters[_Param.id]),
                  ),
                  GoRoute(
                    path: '${_Path.text}${_Path.detail}/:${_Param.id}',
                    builder: (context, state) => FavoriteTextDetail(state.pathParameters[_Param.id]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

abstract class RouterPath {
  static const root = _Path.root;
  static const image = _Path.image;
  static String imageDetail(int id) => '$image${_Path.detail}/$id';
  static const text = _Path.text;
  static String textDetail(int id) => '$text${_Path.detail}/$id';
  static const favorite = _Path.favorite;
  static String favoriteTextDetail(int id) => '$favorite${_Path.text}${_Path.detail}/$id';
  static String favoriteImageDetail(int id) => '$favorite${_Path.image}${_Path.detail}/$id';
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
