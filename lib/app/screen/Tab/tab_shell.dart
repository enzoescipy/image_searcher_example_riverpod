import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/provider/tab_provider.dart';

class TabShell extends ConsumerWidget {
  final Widget navigationShell;
  const TabShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(tabProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Test Page')),
      body: Center(child: navigationShell),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: providerVO.bottomNavigationBarIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.image)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
        ],
      ),
    );
  }
}
