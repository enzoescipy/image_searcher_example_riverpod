import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/service/kakao_api_service/kakao_api.dart';

class ImageItemVO {
  final String imageURL;
  final String title;
  final String dateTime;
  final String body;
  ImageItemVO({required this.imageURL, required this.title, required this.dateTime, required this.body});
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
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
    _mockurlMonalisa,
  ];

  void mockGet() {
    storage.clear();
    currentPage = 0;
    storage.addAll(
      mockUrlList.map(
        (imageURL) => ImageItemVO(imageURL: imageURL, title: "testTitle", dateTime: "너희 어머님 태어난 년도", body: "내가 바디다"),
      ),
    );
  }

  void clear() {
    storage.clear();
    currentPage = 0;
  }

  Future<void> getNextImage(String query) async {
    final Future<List<KakaoImageVO>?> res;
    if (query == queryHistory) {
      currentPage += 1;
      res = KakaoAPI.getImage(query: query, pageNum: currentPage);
    } else {
      queryHistory = query;
      currentPage = 0;
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
  void mockGet() => state.mockGet();
  void clear() => state.clear();
  Future<void> getNextImage(String query) => state.getNextImage(query);
  ImageItemVO getSingleVO(int index) => state.getSingleVO(index);

  @override
  ImageItemVOInterface build() {
    return ImageItemVOInterface();
  }
}
