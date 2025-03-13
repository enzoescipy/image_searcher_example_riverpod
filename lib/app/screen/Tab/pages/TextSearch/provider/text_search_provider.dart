import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';

class TextSearchControllerVO {
  /// search keyward user typed in
  String searchKeyword = "";

  /// loading state
  Future? loadingState;

  /// SingleChildView controller
  ScrollController controller;

  TextSearchControllerVO(this.controller);
}

class TextSearchNotifier extends Notifier<TextSearchControllerVO> {
  /// search bar keyword setter
  set searchKeyword(String value) {
    final newState = TextSearchControllerVO(state.controller);
    newState.searchKeyword = value;
    state = newState;
  }

  /// image future loading state setter
  set loadingState(Future? value) {
    final newState = TextSearchControllerVO(state.controller);
    newState.loadingState = value;
    state = newState;
  }

  void onSubmitQuery(String query) {
    final newState = TextSearchControllerVO(state.controller);
    final imageItemVOInterfaceNotifier = ref.read(VOProviderManager().textItemVOInterfaceProvider);
    newState.searchKeyword = query;
    final res = imageItemVOInterfaceNotifier.getNextText(query);
    newState.loadingState = res;
    state = newState;
  }

  @override
  TextSearchControllerVO build() {
    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent && state.searchKeyword.isNotEmpty) {
        onSubmitQuery(state.searchKeyword);
      }
    });
    return TextSearchControllerVO(controller);
  }
}

final textSearchProvider = NotifierProvider<TextSearchNotifier, TextSearchControllerVO>(() {
  return TextSearchNotifier();
});
