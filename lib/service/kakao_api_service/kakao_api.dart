import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

class KakaoImageVO {
  final String collection;
  final String thumbnailUrl;
  final String imageUrl;
  final String docUrl;
  final String datetime;
  KakaoImageVO({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.docUrl,
    required this.datetime,
  });
}

class kakaoPageVO {
  final String title;
  final String content;
  final String url;
  final String datetime;
  kakaoPageVO({required this.title, required this.content, required this.url, required this.datetime});
}

class KakaoAPI {
  static const defaultSize = 15;
  static Future<List<KakaoImageVO>?> getImage({
    required String query,
    required int pageNum,
    int size = KakaoAPI.defaultSize,
  }) async {
    try {
      Response res = await get(
        Uri.https("dapi.kakao.com", "/v2/search/image", {'query': query, 'page': "$pageNum", 'size': "$size"}),
        headers: {"Authorization": 'KakaoAK 17d7e0a3463cf55e47156470a53522bf'},
      );
      if (res.statusCode == 200) {
        final doc = json.decode(res.body);
        final List<KakaoImageVO> imageVOList = [];
        for (dynamic content in doc["documents"]) {
          final kakao = KakaoImageVO(
            collection: content["collection"],
            thumbnailUrl: content["thumbnail_url"],
            imageUrl: content["image_url"],
            docUrl: content["doc_url"],
            datetime: content["datetime"],
          );

          imageVOList.add(kakao);
        }
        return imageVOList;
      } else {
        log("${res.body}, ${res.headers}, ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  static Future<List<kakaoPageVO>?> getPage({
    required String query,
    required int pageNum,
    int size = KakaoAPI.defaultSize,
  }) async {
    try {
      Response res = await get(
        Uri.https("dapi.kakao.com", "/v2/search/web", {'query': query, 'page': "$pageNum", 'size': "$size"}),
        headers: {"Authorization": 'KakaoAK 17d7e0a3463cf55e47156470a53522bf'},
      );
      if (res.statusCode == 200) {
        final doc = json.decode(res.body);
        final List<kakaoPageVO> imageVOList = [];
        for (dynamic content in doc["documents"]) {
          final kakao = kakaoPageVO(
            title: content["title"],
            content: content["contents"],
            url: content["url"],
            datetime: content["datetime"],
          );

          imageVOList.add(kakao);
        }
        return imageVOList;
      } else {
        log("${res.body}, ${res.headers}, ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
