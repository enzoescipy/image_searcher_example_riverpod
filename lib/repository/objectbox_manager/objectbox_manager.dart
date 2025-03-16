import 'package:image_search/objectbox.g.dart';
import 'package:image_search/repository/objectbox_manager/vo/image_vo.dart';
import 'package:image_search/repository/objectbox_manager/vo/text_vo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ObjectBox {
  static ObjectBox? to;

  late final Store _store;
  late final Box<ImageItemEntity> imageBox;
  late final Box<TextItemEntity> textBox;

  ObjectBox._fromStore() {
    imageBox = _store.box<ImageItemEntity>();
    textBox = _store.box<TextItemEntity>();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<void> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    to = ObjectBox._fromStore();
  }
}

class ObjectboxManager {
  /// singleton pattern
  static final _instance = ObjectboxManager._internal();
  factory ObjectboxManager() {
    return _instance;
  }
  ObjectboxManager._internal();

  static void _put<T>(Box box, T entity) {
    box.put(entity);
  }

  static List<T> _getAll<T>(Box<T> box) {
    return box.getAll();
  }

  void putImageFavorite(ImageItemEntity imageFavoriteItem) {
    _put(ObjectBox.to!.imageBox, imageFavoriteItem);
  }

  void putTextFavorite(TextItemEntity textFavoriteItem) {
    _put(ObjectBox.to!.textBox, textFavoriteItem);
  }

  List<ImageItemEntity> getImageFavorite() {
    return _getAll(ObjectBox.to!.imageBox);
  }

  List<TextItemEntity> getTextFavorite() {
    return _getAll(ObjectBox.to!.textBox);
  }

  void deleteImageFavoriteByUrl(String imageUrl) {
    final query = ObjectBox.to!.imageBox.query(ImageItemEntity_.imageURL.equals(imageUrl)).build();
    query.remove();
  }

  void deleteTextFavoriteByUrl(String url) {
    final query = ObjectBox.to!.textBox.query(TextItemEntity_.url.equals(url)).build();
    query.remove();
  }

}
