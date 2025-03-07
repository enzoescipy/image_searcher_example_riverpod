import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSearchControllerVO {
  String searchKeyword = "";
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

  final _mockurlMonalisa = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0s5B5TIgNtd8NBG31BBu2v1cCxIZi3AEE2g&s";
  final _mockurlHarry = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeZwooMkgerem4IAE2Po97COhiF3MgMT_Vpw&s";

  /// mock URL getter
  List<String> get mockUrlList => [
    _mockurlMonalisa,
    _mockurlHarry,
    _mockurlMonalisa,
    _mockurlHarry,
    _mockurlMonalisa,
    _mockurlHarry,
    _mockurlMonalisa,
  ];

  @override
  ImageSearchControllerVO build() {
    return ImageSearchControllerVO();
  }
}

final imageSearchProvider = NotifierProvider<ImageSearchNotifier, ImageSearchControllerVO>(() {
  return ImageSearchNotifier();
});
