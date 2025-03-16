import 'package:image_search/interface/vo_provider_manager/provider/image_provider.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ImageItemEntity extends ImageItemAbstractVO {
  @Id()
  int id = 0;
  @override
  String? imageURL;
  @override
  String? title;
  @override
  String? dateTime;
  @override
  String? body;
}
