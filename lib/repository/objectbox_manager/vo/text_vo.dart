import 'package:image_search/interface/vo_provider_manager/provider/image_provider.dart';
import 'package:image_search/interface/vo_provider_manager/provider/text_provider.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TextItemEntity extends TextItemAbstractVO {
  @Id()
  int id = 0;
  @override
  String? url;
  @override
  String? title;
  @override
  String? dateTime;
  @override
  String? body;
}
