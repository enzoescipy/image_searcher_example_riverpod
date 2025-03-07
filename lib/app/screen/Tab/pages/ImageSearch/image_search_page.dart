import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_search_provider.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/widget/image_search_widget.dart';
import 'package:image_search/static/static.dart';

class ImageSearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(imageSearchProvider);
    final providerNotifier = ref.read(imageSearchProvider.notifier);
    final mediaQuery = MediaQuery.of(context);

    return Padding(
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
            onSubmitted: (value) => (providerNotifier.searchKeyword = value),
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
          URLImageOrganizer(urlList: providerNotifier.mockUrlList, col: 3, width: mediaQuery.size.width - 20),
        ],
      ),
    );
  }
}
