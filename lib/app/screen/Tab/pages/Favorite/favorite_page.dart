import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/static/static.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('고양이 만세', style: theme.textTheme.headlineMedium), backgroundColor: Palette.background),

      body: Center(child: Text("I am FavoritePage!")),
    );
  }
}
