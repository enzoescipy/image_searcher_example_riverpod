import 'package:image_search/interface/vo_provider_manager/provider/text_provider.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TextItemEntity extends TextItemAbstractVO implements EntityProperty {
  @Id()
  int id = 0;
  @override
  String? creationDateTime;
  @override
  String? url;
  @override
  String? title;
  @override
  String? dateTime;
  @override
  String? body;
}

List<TextItemEntity> getMockTextItemEntityList() {
  return [
    TextItemEntity()
      ..url = "https://placekitten.com/200/200"
      ..title = "Cute Kitten 1"
      ..dateTime = "2024-01-01T10:00:00"
      ..body = "A very adorable kitten playing with yarn"
      ..creationDateTime = "2024-01-01T10:00:00",
    TextItemEntity()
      ..url = "https://placekitten.com/300/300" 
      ..title = "Sleepy Cat"
      ..dateTime = "2024-01-02T15:30:00"
      ..body = "Cat taking an afternoon nap in the sun"
      ..creationDateTime = "2024-01-02T15:30:00",
    TextItemEntity()
      ..url = "https://placekitten.com/400/400"
      ..title = "Playful Kitty"
      ..dateTime = "2024-01-03T09:15:00" 
      ..body = "Energetic kitten chasing a toy mouse"
      ..creationDateTime = "2024-01-03T09:15:00",
  ];
}

