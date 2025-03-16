import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Likebutton extends ConsumerWidget {
  final bool initialState;
  final void Function() likeThen;
  final void Function() dislikeThen;
  late final StateProvider<bool> isLikedProvider;

  Likebutton({super.key, required this.likeThen, required this.dislikeThen, this.initialState = false}) {
    isLikedProvider = StateProvider<bool>((ref) => initialState ? true : false);
  }

  void toggle(WidgetRef ref) {
    final stateBool = (ref.read(isLikedProvider.notifier).state);
    log("statebool : $stateBool");
    ref.read(isLikedProvider.notifier).state = !stateBool;
    if (stateBool == true) {
      log("dislike");
      dislikeThen();
    } else {
      log("like");
      likeThen();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLikedValue = ref.watch(isLikedProvider);

    return GestureDetector(
      onTap: () {
        toggle(ref);
      },
      child:
          isLikedValue
              ? Icon(Icons.favorite, color: Colors.pink, size: 20)
              : Icon(Icons.favorite_border, color: Colors.black45, size: 20),
    );
  }
}
