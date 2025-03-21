import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_search_provider.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/provider/text_search_provider.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/widget/text_organizer.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';
import 'package:image_search/static/static.dart';

class TextSearchPage extends ConsumerWidget {
  const TextSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerNotifier = ref.read(textSearchProvider.notifier);
    final providerVO = ref.watch(textSearchProvider);
    final textItemVOInterface = ref.watch(VOProviderManager().textItemVOInterfaceProvider);

    final favoriteProviderVO = ref.watch(favoriteProvider);
    final favoriteProviderNotifier = ref.read(favoriteProvider.notifier);

    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    // final likedListForVO =
    //     textItemVOInterface.storage.map((textItem) {
    //       final urlFavoritedList = favoriteProviderVO.textFavoriteList.map((item) => item.url);
    //       if (urlFavoritedList.contains(textItem.url)) {
    //         return true;
    //       } else {
    //         return false;
    //       }
    //     }).toList();
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBar(
                onSubmitted: (value) => providerNotifier.onSubmitQuery(value),
                elevation: WidgetStatePropertyAll(1.5),
                backgroundColor: WidgetStatePropertyAll(Palette.secondary25),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.search, color: Palette.elevatedPrimary),
                ),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                constraints: BoxConstraints(
                  maxHeight: 40,
                  minHeight: 40,
                  maxWidth: mediaQuery.size.width * 9 / 10,
                  minWidth: mediaQuery.size.width * 9 / 10,
                ),
              ),
              const SizedBox(height: Dimention.pageVerticalPadding),
              Flexible(
                child: SingleChildScrollView(
                  controller: providerVO.controller,
                  child: FutureBuilder(
                    future: providerVO.loadingState,
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        if (providerVO.loadingState == null || textItemVOInterface.storage.isEmpty) {
                          return URLTextOrganizer(textItemList: [], textItemLikedList: [], onItemTap: (int) {});
                        }
                        return Column(
                          children: [
                            URLTextOrganizer(
                              onLikeButtonTap: favoriteProviderNotifier.refreshFavoriteState,
                              textItemList: textItemVOInterface.storage,
                              textItemLikedList:
                                  textItemVOInterface.storage.map((textItem) {
                                    final urlFavoritedList = favoriteProviderVO.textFavoriteList.map((item) => item.url);
                                    if (urlFavoritedList.contains(textItem.url)) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  }).toList(),
                              onItemTap: (i) => context.go(RouterPath.textDetail(i)),
                            ),

                            CircularProgressIndicator(),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error : ${snapshot.error}");
                      } else {
                        return URLTextOrganizer(
                          onLikeButtonTap: favoriteProviderNotifier.refreshFavoriteState,
                          textItemLikedList:
                              textItemVOInterface.storage.map((textItem) {
                                final urlFavoritedList = favoriteProviderVO.textFavoriteList.map((item) => item.url);
                                if (urlFavoritedList.contains(textItem.url)) {
                                  return true;
                                } else {
                                  return false;
                                }
                              }).toList(),
                          onItemTap: (i) => context.go(RouterPath.textDetail(i)),
                          textItemList: textItemVOInterface.storage,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
