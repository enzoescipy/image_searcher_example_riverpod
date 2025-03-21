import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/app/screen/Tab/widget/like_button.dart';
import 'package:image_search/interface/vo_provider_manager/provider/image_provider.dart';
import 'package:image_search/repository/objectbox_manager/objectbox_manager.dart';
import 'package:image_search/static/static.dart';

class URLImageOrganizer extends StatelessWidget {
  final List<ImageItemVO> itemVOList;
  final List<bool> itemVOLikedList;
  final void Function(int index) onItemTap;
  final int col;
  final double width;
  final double margin;
  late final double imageWidth;

  final void Function()? onLikeButtonTap;

  URLImageOrganizer({
    super.key,
    required this.itemVOList,
    required this.itemVOLikedList,
    required this.onItemTap,
    required this.col,
    required this.width,
    this.margin = 2.5,
    this.onLikeButtonTap,
  }) {
    imageWidth = (width - (col - 1) * margin) / col;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [];
    int i = 0;
    while (true) {
      final currentRow = _digestRow(i, context);
      if (currentRow == null) {
        break;
      } else {
        widgetList.add(Row(children: currentRow));
        widgetList.add(SizedBox(height: margin));
      }
      i++;
    }
    if (widgetList.isNotEmpty) {
      widgetList.removeLast();
      return SizedBox(child: Column(children: widgetList), width: width);
    } else {
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.help_outline_outlined, size: 70, color: Palette.secondary),
            SizedBox(height: 20),
            Text("검색 결과가 없습니다.", style: Theme.of(context).textTheme.headlineMedium?.apply(color: Palette.secondary)),
          ],
        ),
        width: width,
        height: MediaQuery.of(context).size.height / 2,
      );
    }
  }

  List<Widget>? _digestRow(int order, BuildContext context) {
    final fromRange = order * col;
    int toRange = (order + 1) * col;
    if (toRange > itemVOList.length) {
      toRange = itemVOList.length;
    }
    if (toRange < fromRange) {
      return null;
    }

    final List<Widget> widgetList = [];

    for (int i = fromRange; i < toRange; i++) {
      final imageItem = itemVOList[i];
      final imageItemLiked = itemVOLikedList[i];
      final imageWidget = Image.network(
        imageItem.imageURL,
        width: imageWidth,
        height: imageWidth,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(color: Colors.white, width: imageWidth, height: imageWidth);
        },
      );
      final clickableWidget = Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            child: imageWidget,
            onTap: () {
              onItemTap(i);
            },
          ),
          Likebutton(
            initialState: imageItemLiked,
            likeThen: () {
              ObjectBoxManager().putImageFavorite(imageItem.toEntity());
              if (onLikeButtonTap != null) {
                onLikeButtonTap!();
              }
            },
            dislikeThen: () {
              ObjectBoxManager().deleteImageFavoriteByUrl(imageItem.imageURL);
              if (onLikeButtonTap != null) {
                onLikeButtonTap!();
              }
            },
          ),
        ],
      );
      widgetList.add(clickableWidget);
      widgetList.add(SizedBox(width: margin));
    }

    if (widgetList.isEmpty) {
      return null;
    } else {
      widgetList.removeLast();
      return widgetList;
    }
  }
}
