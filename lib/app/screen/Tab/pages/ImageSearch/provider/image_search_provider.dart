import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';

class ImageSearchControllerVO {
  /// search keyward user typed in
  String searchKeyword = "";

  /// loading state
  Future? loadingState;

  /// SingleChildView controller
  ScrollController controller;

  ImageSearchControllerVO(this.controller);
}

class ImageSearchNotifier extends Notifier<ImageSearchControllerVO> {
  /// search bar keyword setter
  set searchKeyword(String value) {
    final newState = ImageSearchControllerVO(state.controller);
    newState.searchKeyword = value;
    state = newState;
  }

  /// image future loading state setter
  set loadingState(Future? value) {
    final newState = ImageSearchControllerVO(state.controller);
    newState.loadingState = value;
    state = newState;
  }

  void onSubmitQuery(String query) {
    final newState = ImageSearchControllerVO(state.controller);
    final imageItemVOInterfaceNotifier = ref.read(VOProviderManager().imageItemVOInterfaceProvider.notifier);
    newState.searchKeyword = query;
    final res = imageItemVOInterfaceNotifier.getNextImage(query);
    newState.loadingState = res;
    state = newState;
  }

  @override
  ImageSearchControllerVO build() {
    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent && state.searchKeyword.isNotEmpty) {
        onSubmitQuery(state.searchKeyword);
      }
    });
    return ImageSearchControllerVO(controller);
  }
}

final imageSearchProvider = NotifierProvider<ImageSearchNotifier, ImageSearchControllerVO>(() {
  return ImageSearchNotifier();
});
