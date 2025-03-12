import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/Tab/provider/tab_provider.dart';
import 'package:image_search/static/static.dart';

class TabShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const TabShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(tabProvider);
    final providerNotifier = ref.read(tabProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(child: navigationShell),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Palette.background,
        currentIndex: providerVO.bottomNavigationBarIndex,
        selectedLabelStyle: theme.textTheme.bodySmall,
        unselectedLabelStyle: theme.textTheme.bodySmall,
        unselectedItemColor: Palette.secondary,
        selectedItemColor: Palette.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.image, color: Palette.secondary),
            activeIcon: Icon(Icons.image, color: Palette.primary),
            label: "image",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Palette.secondary),
            activeIcon: Icon(Icons.search, color: Palette.primary),
            label: "search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Palette.secondary),
            activeIcon: Icon(Icons.favorite, color: Palette.primary),
            label: "favorite",
          ),
        ],
        onTap: (i) {
          providerNotifier.bottomNavigationBarIndex = i;
          navigationShell.goBranch(i);
        },
      ),
    );
  }
}
