import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PageMenuChoice { all, image, text }

class FavoriteControllerVO {
  PageMenuChoice pageMenuChoice = PageMenuChoice.all;
}

class FavoriteNotifier extends Notifier<FavoriteControllerVO> {
  set pageMenuChoice(PageMenuChoice value) {
    final newState = FavoriteControllerVO();
    newState.pageMenuChoice = value;
    state = newState;
  }

  @override
  FavoriteControllerVO build() {
    return FavoriteControllerVO();
  }
}

final favoriteProvider = NotifierProvider<FavoriteNotifier, FavoriteControllerVO>(() => FavoriteNotifier());
