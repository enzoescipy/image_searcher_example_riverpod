import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/interface/vo_provider_manager/provider/image_provider.dart';
import 'package:image_search/interface/vo_provider_manager/provider/text_provider.dart';

class VOProviderManager {
  /// singleton pattern
  static final _instance = VOProviderManager._internal();
  factory VOProviderManager() {
    return _instance;
  }
  VOProviderManager._internal();

  final imageItemVOInterfaceProvider = NotifierProvider<ImageItemNotifier, ImageItemVOInterface>(() => ImageItemNotifier());
  final textItemVOInterfaceProvider = NotifierProvider<TextItemNotifier, TextItemVOInterface>(() => TextItemNotifier());
}
