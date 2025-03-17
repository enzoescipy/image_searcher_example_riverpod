import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:image_search/static/static.dart';

class FavoriteTextDetail extends ConsumerWidget {
  final String? id;
  const FavoriteTextDetail(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(favoriteProvider);
    final textItem = providerVO.textFavoriteList[int.parse(id ?? "-1")];

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('고양이 만세', style: theme.textTheme.headlineMedium), backgroundColor: Palette.background),
      body: Padding(
        padding: EdgeInsets.only(right: Dimention.pageHorizontalPadding, left: Dimention.pageHorizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        Text("${textItem.title}", style: theme.textTheme.headlineMedium),
                        Row(children: [Icon(Icons.date_range_outlined), Text("${textItem.dateTime}")]),
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
                      child: Row(children: [Icon(Icons.format_quote), Flexible(child: Text(textItem.body ?? ""))]),
                    ),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Palette.background),
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
