import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/repository/objectbox_manager/vo/image_vo.dart';
import 'package:image_search/service/kakao_api_service/kakao_api.dart';

abstract class ImageItemAbstractVO {
  abstract final String? imageURL;
  abstract final String? title;
  abstract final String? dateTime;
  abstract final String? body;
}

class ImageItemVO extends ImageItemAbstractVO {
  @override
  final String imageURL;
  @override
  final String title;
  @override
  final String dateTime;
  @override
  final String body;
  ImageItemVO({required this.imageURL, required this.title, required this.dateTime, required this.body});
  ImageItemEntity toEntity() {
    final res = ImageItemEntity();
    res.imageURL = imageURL;
    res.title = title;
    res.dateTime = dateTime;
    res.body = body;
    return res;
  }
}

class ImageItemVOInterface {
  final List<ImageItemVO> storage = [];
  String queryHistory = "";
  int currentPage = 0;

  ImageItemVOInterface({List<ImageItemVO>? initial}) {
    if (initial != null) {
      storage.addAll(initial);
    }
  }

  void clear() {
    storage.clear();
    currentPage = 0;
  }

  Future<void>? getNextImage(String query) async {
    if (query.isEmpty) {
      clear();
      return;
    }

    final Future<List<KakaoImageVO>?> res;
    if (query == queryHistory) {
      currentPage += 1;
      res = KakaoAPI.getImage(query: query, pageNum: currentPage);
    } else {
      queryHistory = query;
      currentPage = 0;
      clear();
      res = KakaoAPI.getImage(query: query, pageNum: currentPage);
    }

    return res.then((List<KakaoImageVO>? kakaoList) {
      for (KakaoImageVO kakao in kakaoList ?? []) {
        final target = ImageItemVO(
          title: kakao.collection,
          imageURL: kakao.imageUrl,
          dateTime: kakao.datetime,
          body: kakao.collection,
        );
        storage.add(target);
      }
    });
  }

  ImageItemVO getSingleVO(int index) => storage[index];
}

class ImageItemNotifier extends Notifier<ImageItemVOInterface> {
  void clear() => state.clear();
  Future<void>? getNextImage(String query) => state.getNextImage(query);
  ImageItemVO getSingleVO(int index) => state.getSingleVO(index);

  @override
  ImageItemVOInterface build() {
    return ImageItemVOInterface();
  }
}
