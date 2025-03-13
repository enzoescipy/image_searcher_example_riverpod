import 'package:image_search/service/kakao_api_service/kakao_api.dart';

void main() async {
  print("${(await KakaoAPI.getImage(query: "설현", pageNum: 15))}");
}
