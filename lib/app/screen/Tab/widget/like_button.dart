import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Likebutton extends ConsumerWidget {
  final bool isReversed;
  final void Function() likeThen;
  final void Function() dislikeThen;
  late final StateProvider<bool> isLikedProvider;

  Likebutton({
    super.key,
    required this.likeThen,
    required this.dislikeThen,
    this.isReversed = false,
  }) {
    isLikedProvider = StateProvider<bool>((ref) => isReversed ? true : false);
  }

  void toggle(WidgetRef ref) {
    final stateBool = (ref.read(isLikedProvider.notifier).state);
    ref.read(isLikedProvider.notifier).state = !stateBool;
    if (stateBool == true) {
      dislikeThen();
    } else {
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
