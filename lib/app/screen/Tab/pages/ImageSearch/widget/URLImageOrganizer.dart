import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';

class URLImageOrganizer extends ConsumerWidget {
  final List<ImageItemVO> urlList;
  final int col;
  final double width;
  final double margin;
  late final double imageWidth;

  URLImageOrganizer({super.key, required this.urlList, required this.col, required this.width, this.margin = 2.5}) {
    imageWidth = (width - (col - 1) * margin) / col;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    widgetList.removeLast();

    return SizedBox(child: Column(children: widgetList), width: width);
  }

  List<Widget>? _digestRow(int order, BuildContext context) {
    final fromRange = order * col;
    int toRange = (order + 1) * col;
    if (toRange > urlList.length) {
      toRange = urlList.length;
    }
    if (toRange < fromRange) {
      return null;
    }

    final List<Widget> widgetList = [];

    for (int i = fromRange; i < toRange; i++) {
      final imageItem = urlList[i];
      final imageWidget = Image.network(imageItem.imageURL, width: imageWidth, height: imageWidth, fit: BoxFit.fitWidth);
      final clickableWidget = GestureDetector(child: imageWidget, onTap: () => context.go(RouterPath.imageDetail(i)));
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
