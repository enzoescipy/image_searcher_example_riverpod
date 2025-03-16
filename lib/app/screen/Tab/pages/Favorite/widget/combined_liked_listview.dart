import 'package:flutter/material.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:image_search/app/screen/Tab/widget/like_button.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';

class CombinedLikedListview extends StatelessWidget {
  final Widget thumb;
  final String body;
  final String dateTime;

  final PageMenuChoice widgetType;
  final String url;

  const CombinedLikedListview({
    super.key,
    required this.thumb,
    required this.body,
    required this.dateTime,
    required this.widgetType,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widgetType == PageMenuChoice.all) {
      return Text("you should define the widget type!!");
    }
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ListTile(
          title: thumb,
          leading: SizedBox(
            width: 100,
            child: Text(body, style: theme.textTheme.titleSmall?.apply(overflow: TextOverflow.ellipsis), maxLines: 2),
          ),
          trailing: Text((dateTime).split('T')[0], style: theme.textTheme.bodyMedium),
        ),
        Likebutton(
          isReversed: true,
          likeThen: () {},
          dislikeThen: () {
            switch (widgetType) {
              case PageMenuChoice.image:
                ObjectBoxManager().deleteImageFavoriteByUrl(url);
                break;
              case PageMenuChoice.text:
                ObjectBoxManager().deleteTextFavoriteByUrl(url);
                break;
              default:
                break;
            }
          },
        ),
      ],
    );
  }
}
