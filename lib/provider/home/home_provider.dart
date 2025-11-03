import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider =
StateNotifierProvider.autoDispose<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier(0);
});

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier(super.state);

  void setIndex(int index) {
    state = index;
  }
}