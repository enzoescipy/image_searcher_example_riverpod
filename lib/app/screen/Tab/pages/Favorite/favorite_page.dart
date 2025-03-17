import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/widget/combined_liked_listview.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/widget/url_image_organizer.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/widget/text_organizer.dart';
import 'package:image_search/interface/vo_provider_manager/provider/image_provider.dart';
import 'package:image_search/interface/vo_provider_manager/provider/text_provider.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:image_search/repository/objectbox_manager/vo/image_vo.dart';
import 'package:image_search/repository/objectbox_manager/vo/text_vo.dart';
import 'package:image_search/static/static.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(favoriteProvider);
    final providerNotifier = ref.read(favoriteProvider.notifier);

    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final Widget content;
    switch (providerVO.pageMenuChoice) {
      case PageMenuChoice.all:
        final creationDateTimeSorted =
            providerVO.imageFavoriteList.map((item) => item.creationDateTime).toList() +
            providerVO.textFavoriteList.map((item) => item.creationDateTime).toList();
        creationDateTimeSorted.sort((a, b) {
          if (a == null && b == null) {
            return 0;
          } else if (a == null && b != null) {
            return -1;
          } else if (a != null && b == null) {
            return 1;
          }

          final creationTimeA = DateTime.parse(a ?? "");
          final creationTimeB = DateTime.parse(b ?? "");

          return creationTimeA.compareTo(creationTimeB);
        });
        final listviewItemList = <Widget>[];

        for (String? creationTime in creationDateTimeSorted) {
          if (creationTime == null) {
            continue;
          }

          final imageItemIndex = providerVO.imageFavoriteList.indexWhere((item) => item.creationDateTime == creationTime);
          final textItemIndex = providerVO.textFavoriteList.indexWhere((item) => item.creationDateTime == creationTime);

          if (imageItemIndex != -1) {
            final imageItem = providerVO.imageFavoriteList[imageItemIndex];
            listviewItemList.add(
              CombinedLikedListview(
                onTap: () {
                  context.go(RouterPath.favoriteImageDetail(imageItemIndex));
                },
                onLikeButtonTap: providerNotifier.refreshFavoriteState,
                thumb: Image.network(imageItem.imageURL ?? "", width: 100, height: 100),
                body: imageItem.title ?? "",
                dateTime: imageItem.dateTime ?? "",
                widgetType: PageMenuChoice.image,
                url: imageItem.imageURL ?? "",
              ),
            );
          } else if (textItemIndex != -1) {
            final textItem = providerVO.textFavoriteList[textItemIndex];
            listviewItemList.add(
              CombinedLikedListview(
                onTap: () {
                  context.go(RouterPath.favoriteTextDetail(textItemIndex));
                },
                onLikeButtonTap: providerNotifier.refreshFavoriteState,
                thumb: Text(textItem.body ?? "", maxLines: 3),
                body: textItem.title ?? "",
                dateTime: textItem.dateTime ?? "",
                widgetType: PageMenuChoice.text,
                url: textItem.url ?? "",
              ),
            );
          }
        }

        content = Flexible(child: ListView(children: listviewItemList));
        break;
      case PageMenuChoice.image:
        content = URLImageOrganizer(
          onLikeButtonTap: providerNotifier.refreshFavoriteState,
          itemVOLikedList: providerVO.imageFavoriteList.map((item) => true).toList(),
          itemVOList: providerVO.imageFavoriteList.map((item) => ImageItemVO.fromEntity(item)).toList(),
          onItemTap: (i) {
            log("path : ${RouterPath.favoriteImageDetail(i)}");
            context.go(RouterPath.favoriteImageDetail(i));
          },
          col: 3,
          width: mediaQuery.size.width - 20,
        );
        break;
      case PageMenuChoice.text:
        content = URLTextOrganizer(
          onLikeButtonTap: providerNotifier.refreshFavoriteState,
          isReversedLikeStatae: true,
          textItemLikedList: providerVO.textFavoriteList.map((item) => true).toList(),
          textItemList: providerVO.textFavoriteList.map((item) => TextItemVO.toEntity(item)).toList(),
          onItemTap: (i) => context.go(RouterPath.favoriteTextDetail(i)),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: Text('고양이 만세', style: theme.textTheme.headlineMedium), backgroundColor: Palette.background),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            right: Dimention.pageHorizontalPadding,
            top: Dimention.pageVerticalPadding,
            left: Dimention.pageHorizontalPadding,
          ),
          child: Column(
            children: [
              DropdownButton(
                value: providerVO.pageMenuChoice,
                onChanged: (value) {
                  providerNotifier.pageMenuChoice = value ?? PageMenuChoice.all;
                },
                items: [
                  DropdownMenuItem(value: PageMenuChoice.all, child: Text("전체")),
                  DropdownMenuItem(value: PageMenuChoice.image, child: Text("이미지")),
                  DropdownMenuItem(value: PageMenuChoice.text, child: Text("텍스트")),
                ],
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
