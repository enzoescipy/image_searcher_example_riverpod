import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/app/screen/Tab/widget/like_button.dart';
import 'package:image_search/interface/vo_provider_manager/provider/text_provider.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:image_search/static/static.dart';

class URLTextOrganizer extends StatelessWidget {
  final List<TextItemVO> textItemList;
  final List<bool> textItemLikedList;
  final bool isReversedLikeStatae;
  final void Function()? onLikeButtonTap;
  final void Function(int) onItemTap;

  URLTextOrganizer({
    super.key,
    required this.textItemList,
    required this.textItemLikedList,
    required this.onItemTap,
    this.isReversedLikeStatae = false,
    this.onLikeButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (textItemList.isNotEmpty) {
      final List<Widget> itemWidgetList = [];
      for (int i = 0; i < textItemList.length; i++) {
        log("${textItemList.length}, ${textItemLikedList.length}");
        final item = textItemList[i];
        final itemLiked = textItemLikedList[i];
        itemWidgetList.add(
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: PhysicalModel(
                  elevation: 3.0,
                  color: Colors.black,
                  child: GestureDetector(
                    onTap: () {
                      onItemTap(i);
                    },
                    child: Container(
                      color: Palette.white,
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          item.body,
                          style: theme.textTheme.bodyMedium?.apply(overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                        leading: SizedBox(
                          width: 100,
                          child: Text(
                            item.title,
                            style: theme.textTheme.titleSmall?.apply(overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                        trailing: Text((item.dateTime).split('T')[0], style: theme.textTheme.bodyMedium),
                      ),
                    ),
                  ),
                ),
              ),
              Likebutton(
                initialState: itemLiked,
                likeThen: () {
                  ObjectBoxManager().putTextFavorite(item.toEntity());
                  if (onLikeButtonTap != null) {
                    onLikeButtonTap!();
                  }
                },
                dislikeThen: () {
                  ObjectBoxManager().deleteTextFavoriteByUrl(item.url);
                  if (onLikeButtonTap != null) {
                    onLikeButtonTap!();
                  }
                },
              ),
            ],
          ),
        );
      }
      return Column(children: itemWidgetList);
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.help_outline_outlined, size: 70, color: Palette.secondary),
            SizedBox(height: 20),
            Text("검색 결과가 없습니다.", style: Theme.of(context).textTheme.headlineMedium?.apply(color: Palette.secondary)),
          ],
        ),
      );
    }
  }
}
