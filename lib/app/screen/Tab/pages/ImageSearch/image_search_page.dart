import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_search_provider.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/widget/url_image_organizer.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';
import 'package:image_search/static/static.dart';

class ImageSearchPage extends ConsumerWidget {
  const ImageSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerNotifier = ref.read(imageSearchProvider.notifier);
    final providerVO = ref.watch(imageSearchProvider);

    final favoriteProviderVO = ref.watch(favoriteProvider);
    final favoriteProviderNotifier = ref.read(favoriteProvider.notifier);

    final mediaQuery = MediaQuery.of(context);
    final imageItemVOInterface = ref.watch(VOProviderManager().imageItemVOInterfaceProvider);
    final theme = Theme.of(context);

    // final likedListForVO =
    //     imageItemVOInterface.storage.map((imageVO) {
    //       final urlFavoritedList = favoriteProviderVO.imageFavoriteList.map((item) => item.imageURL);
    //       if (urlFavoritedList.contains(imageVO.imageURL)) {
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
                  // child: URLImageOrganizer(urlList: imageItemVOInterface.storage, col: 3, width: mediaQuery.size.width - 20),
                  child: FutureBuilder(
                    future: providerVO.loadingState,
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        if (providerVO.loadingState == null || imageItemVOInterface.storage.isEmpty) {
                          return URLImageOrganizer(
                            itemVOLikedList: [],
                            itemVOList: [],
                            col: 3,
                            width: mediaQuery.size.width - 20,
                            onItemTap: (int index) {},
                          );
                        }
                        return Column(
                          children: [
                            URLImageOrganizer(
                              onLikeButtonTap: favoriteProviderNotifier.refreshFavoriteState,
                              itemVOList: imageItemVOInterface.storage,
                              itemVOLikedList:
                                  imageItemVOInterface.storage.map((imageVO) {
                                    final urlFavoritedList = favoriteProviderVO.imageFavoriteList.map((item) => item.imageURL);
                                    if (urlFavoritedList.contains(imageVO.imageURL)) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  }).toList(),
                              onItemTap: (i) {
                                context.go(RouterPath.imageDetail(i));
                              },
                              col: 3,
                              width: mediaQuery.size.width - 20,
                            ),
                            CircularProgressIndicator(),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error : ${snapshot.error}");
                      } else {
                        return URLImageOrganizer(
                          onLikeButtonTap: favoriteProviderNotifier.refreshFavoriteState,
                          itemVOList: imageItemVOInterface.storage,
                          itemVOLikedList:
                              imageItemVOInterface.storage.map((imageVO) {
                                final urlFavoritedList = favoriteProviderVO.imageFavoriteList.map((item) => item.imageURL);
                                if (urlFavoritedList.contains(imageVO.imageURL)) {
                                  return true;
                                } else {
                                  return false;
                                }
                              }).toList(),
                          onItemTap: (i) {
                            context.go(RouterPath.imageDetail(i));
                          },
                          col: 3,
                          width: mediaQuery.size.width - 20,
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
