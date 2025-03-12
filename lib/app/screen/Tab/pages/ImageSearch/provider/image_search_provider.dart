import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSearchControllerVO {
  /// search keyward user typed in
  String searchKeyword = "";

  Future? loadingState;
}

class ImageSearchNotifier extends Notifier<ImageSearchControllerVO> {
  /// search bar keyword getter
  String get searchKeyword => state.searchKeyword;

  /// search bar keyword setter
  set searchKeyword(String value) {
    final newState = ImageSearchControllerVO();
    newState.searchKeyword = value;
    state = newState;
  }

  /// image future loading state getter
  Future? get loadingState => state.loadingState;

  /// image future loading state setter
  set loadingState(Future? value) => value;

  @override
  ImageSearchControllerVO build() {
    return ImageSearchControllerVO();
  }
}

final imageSearchProvider = NotifierProvider<ImageSearchNotifier, ImageSearchControllerVO>(() {
  return ImageSearchNotifier();
});
