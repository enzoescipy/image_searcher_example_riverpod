import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:image_search/repository/objectbox_manager/vo/image_vo.dart';
import 'package:image_search/repository/objectbox_manager/vo/text_vo.dart';

enum PageMenuChoice { all, image, text }

class FavoriteControllerVO {
  PageMenuChoice pageMenuChoice = PageMenuChoice.all;

  List<ImageItemEntity> imageFavoriteList = ObjectBoxManager().getImageFavorite();
  List<TextItemEntity> textFavoriteList = ObjectBoxManager().getTextFavorite();
}

class FavoriteNotifier extends Notifier<FavoriteControllerVO> {
  set pageMenuChoice(PageMenuChoice value) {
    final newState = FavoriteControllerVO();
    newState.pageMenuChoice = value;
    state = newState;
  }

  void refreshFavoriteState() {
    final newState = FavoriteControllerVO();
    newState.pageMenuChoice = state.pageMenuChoice;
    state = newState;
  }

  @override
  FavoriteControllerVO build() {
    return FavoriteControllerVO();
  }
}

final favoriteProvider = NotifierProvider<FavoriteNotifier, FavoriteControllerVO>(() => FavoriteNotifier());
