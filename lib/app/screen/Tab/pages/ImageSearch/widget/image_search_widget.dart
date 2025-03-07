import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class URLImageOrganizer extends ConsumerWidget {
  final List<String> urlList;
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
      final currentRow = _digestRow(i);
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

  List<Widget>? _digestRow(int order) {
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
      final targetURL = urlList[i];
      final imageWidget = Image.network(targetURL, width: imageWidth, height: imageWidth, fit: BoxFit.fitWidth);
      widgetList.add(imageWidget);
      widgetList.add(SizedBox(width: margin));
    }

    widgetList.removeLast();
    return widgetList;
  }
}
