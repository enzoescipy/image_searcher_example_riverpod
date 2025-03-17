import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:image_search/static/static.dart';

class FavoriteImageDetail extends ConsumerWidget {
  final String? id;
  const FavoriteImageDetail(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(favoriteProvider);
    final imageItem = providerVO.imageFavoriteList[int.parse(id ?? "-1")];

    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final imageWidget = Image.network(imageItem.imageURL ?? "", width: mediaQuery.size.width - 20, fit: BoxFit.fitWidth);
    return Scaffold(
      appBar: AppBar(title: Text('고양이 만세', style: theme.textTheme.headlineMedium), backgroundColor: Palette.background),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(right: Dimention.pageHorizontalPadding, left: Dimention.pageHorizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(15), child: imageWidget),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(
                    elevation: 2.0,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Palette.secondary50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${imageItem.title}", style: theme.textTheme.headlineMedium),
                          Row(children: [Icon(Icons.date_range_outlined), Text("${imageItem.dateTime}")]),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                  child: PhysicalModel(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [Icon(Icons.format_quote), Text("${imageItem.body}")]),
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Palette.background),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
