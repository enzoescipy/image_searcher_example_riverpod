import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_search_provider.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/widget/URLImageOrganizer.dart';
import 'package:image_search/interface/vo_provider_manager/vo_provider_manager.dart';
import 'package:image_search/static/static.dart';

class ImageSearchPage extends ConsumerWidget {
  const ImageSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerNotifier = ref.read(imageSearchProvider.notifier);
    final mediaQuery = MediaQuery.of(context);
    final imageItemVOInterfaceNotifier = ref.read(VOProviderManager().imageItemVOInterfaceProvider.notifier);
    // imageItemVOInterfaceNotifier.mockGet();
    final imageItemVOInterface = ref.watch(VOProviderManager().imageItemVOInterfaceProvider);
    final theme = Theme.of(context);

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
                onSubmitted: (value) {
                  providerNotifier.searchKeyword = value;
                  final res = imageItemVOInterfaceNotifier.getNextImage(providerNotifier.searchKeyword);
                  providerNotifier.loadingState = res;
                },
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
                  // child: URLImageOrganizer(urlList: imageItemVOInterface.storage, col: 3, width: mediaQuery.size.width - 20),
                  child: FutureBuilder(
                    future: providerNotifier.loadingState,
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return Column(
                          children: [
                            URLImageOrganizer(urlList: imageItemVOInterface.storage, col: 3, width: mediaQuery.size.width - 20),
                            CircularProgressIndicator(),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error : ${snapshot.error}");
                      } else {
                        return URLImageOrganizer(
                          urlList: imageItemVOInterface.storage,
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
