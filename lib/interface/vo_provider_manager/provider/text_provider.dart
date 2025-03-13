import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/service/kakao_api_service/kakao_api.dart';

class TextItemVO {
  final String title;
  final String dateTime;
  final String body;
  TextItemVO({required this.title, required this.dateTime, required this.body});
}

class TextItemVOInterface {
  final List<TextItemVO> storage = [];
  String queryHistory = "";
  int currentPage = 0;

  TextItemVOInterface({List<TextItemVO>? initial}) {
    if (initial != null) {
      storage.addAll(initial);
    }
  }

  void clear() {
    storage.clear();
    currentPage = 0;
  }

  Future<void> getNextText(String query) async {
    final Future<List<kakaoPageVO>?> res;
    if (query == queryHistory) {
      currentPage += 1;
      res = KakaoAPI.getPage(query: query, pageNum: currentPage);
    } else {
      queryHistory = query;
      currentPage = 0;
      res = KakaoAPI.getPage(query: query, pageNum: currentPage);
    }

    return res.then((List<kakaoPageVO>? kakaoList) {
      for (kakaoPageVO kakao in kakaoList ?? []) {
        final target = TextItemVO(title: kakao.title, dateTime: kakao.datetime, body: kakao.content);
        storage.add(target);
      }
    });
  }

  TextItemVO getSingleVO(int index) => storage[index];
}

class TextItemNotifier extends Notifier<TextItemVOInterface> {
  void clear() => state.clear();
  Future<void> getNextText(String query) => state.getNextText(query);
  TextItemVO getSingleVO(int index) => state.getSingleVO(index);

  @override
  TextItemVOInterface build() {
    return TextItemVOInterface();
  }
}
