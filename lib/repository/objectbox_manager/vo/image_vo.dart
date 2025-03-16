import 'package:image_search/interface/vo_provider_manager/provider/image_provider.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ImageItemEntity extends ImageItemAbstractVO implements EntityProperty {
  @Id()
  int id = 0;
  @override
  String? creationDateTime;
  @override
  String? imageURL;
  @override
  String? title;
  @override
  String? dateTime;
  @override
  String? body;
}

List<ImageItemEntity> getMockImageItemEntityList() {
  return [
    ImageItemEntity()
      ..imageURL = "https://placekitten.com/500/500"
      ..title = "Curious Cat"
      ..dateTime = "2024-01-01T12:00:00"
      ..body = "A curious cat exploring its surroundings"
      ..creationDateTime = "2024-01-01T12:00:00",
    ImageItemEntity()
      ..imageURL = "https://placekitten.com/600/600"
      ..title = "Lazy Afternoon"
      ..dateTime = "2024-01-02T14:30:00"
      ..body = "Cat lounging in a sunny window"
      ..creationDateTime = "2024-01-02T14:30:00",
    ImageItemEntity()
      ..imageURL = "https://placekitten.com/700/700"
      ..title = "Mischievous Kitten"
      ..dateTime = "2024-01-03T16:45:00"
      ..body = "Little troublemaker getting into everything"
      ..creationDateTime = "2024-01-03T16:45:00",
  ];
}
