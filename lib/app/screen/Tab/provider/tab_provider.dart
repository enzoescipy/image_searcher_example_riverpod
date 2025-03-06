import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabControllerVO {
  int bottomNavigationBarIndex = 0;
}

class TabNotifier extends Notifier<TabControllerVO> {
  @override
  build() {
    return TabControllerVO();
  }
}

final tabProvider = NotifierProvider<TabNotifier, TabControllerVO>(() {
  return TabNotifier();
});
