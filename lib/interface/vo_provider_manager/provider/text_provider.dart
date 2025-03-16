import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/repository/objectbox_manager/vo/text_vo.dart';
import 'package:image_search/service/kakao_api_service/kakao_api.dart';

abstract class TextItemAbstractVO {
  abstract final String? url;
  abstract final String? title;
  abstract final String? dateTime;
  abstract final String? body;
}

class TextItemVO extends TextItemAbstractVO {
  @override
  late final String url;
  @override
  late final String title;
  @override
  late final String dateTime;
  @override
  late final String body;
  TextItemVO({required this.url, required this.title, required this.dateTime, required this.body});

  TextItemVO.toEntity(TextItemEntity entity) {
    url = entity.url ?? "";
    title = entity.title ?? "";
    dateTime = entity.dateTime ?? "";
    body = entity.body ?? "";
  }

  TextItemEntity toEntity() {
    final res = TextItemEntity();
    res.url = url;
    res.title = title;
    res.dateTime = dateTime;
    res.body = body;
    return res;
  }
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

  Future<void>? getNextText(String query) async {
    if (query.isEmpty) {
      clear();
      return;
    }

    final Future<List<kakaoPageVO>?> res;
    if (query == queryHistory) {
      currentPage += 1;
      res = KakaoAPI.getPage(query: query, pageNum: currentPage);
    } else {
      queryHistory = query;
      currentPage = 0;
      clear();
      res = KakaoAPI.getPage(query: query, pageNum: currentPage);
    }

    return res.then((List<kakaoPageVO>? kakaoList) {
      for (kakaoPageVO kakao in kakaoList ?? []) {
        final target = TextItemVO(url: kakao.url, title: kakao.title, dateTime: kakao.datetime, body: kakao.content);
        storage.add(target);
      }
    });
  }

  TextItemVO getSingleVO(int index) => storage[index];
}

class TextItemNotifier extends Notifier<TextItemVOInterface> {
  void clear() => state.clear();
  Future<void>? getNextText(String query) => state.getNextText(query);
  TextItemVO getSingleVO(int index) => state.getSingleVO(index);

  @override
  TextItemVOInterface build() {
    return TextItemVOInterface();
  }
}
