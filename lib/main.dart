import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';
import 'package:image_search/objectbox.g.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:image_search/service/kakao_api_service/kakao_api.dart';
import 'package:image_search/static/static.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ObjectBox.create(); // run `dart run build_runner build` to apply the modified ObjectBox

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: RouterOutlet.router,
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: Palette.primary, secondary: Palette.secondary),
          scaffoldBackgroundColor: Palette.white,
          textTheme: TextTheme(
            headlineMedium: TextStyle(color: Palette.black, fontSize: 26, fontFamily: 'PretendardBold'),
            bodyMedium: TextStyle(color: Palette.black, fontSize: 16, fontFamily: 'PretendardRegular'),
            bodySmall: TextStyle(color: Palette.black, fontSize: 12, fontFamily: 'PretendardRegular'),
          ),
        ),
      ),
    ),
  );
}
