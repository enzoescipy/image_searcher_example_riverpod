import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Likebutton extends ConsumerWidget {
  Likebutton({super.key, required this.then});

  final void Function() then;
  final isLikedProvider = StateProvider<bool>((ref) => false);

  void toggle(WidgetRef ref) {
    ref.read(isLikedProvider.notifier).state = !(ref.read(isLikedProvider.notifier).state);
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
