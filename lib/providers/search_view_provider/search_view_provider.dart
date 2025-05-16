import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

/// Tracks the currently selected step in the UI (1-based index)
final selectedStepProvider = StateProvider<int>((ref) => 1);

/// Provides a single instance of PageController
final pageControllerProvider = Provider<PageController>((ref) => PageController());

/// Tracks whether the drawer is open or closed
final drawerStateProvider = StateProvider<bool>((ref) => false);

/// Provides a GlobalKey to control the SliderDrawer state
final drawerKeyProvider = Provider<GlobalKey<SliderDrawerState>>(
        (ref) => GlobalKey<SliderDrawerState>());

/// Handles interactions related to search steps and drawer behavior
class SearchResultsController {
  final WidgetRef ref;
  SearchResultsController(this.ref);

  /// Updates selected step and scrolls to corresponding page
  void onStepTapped(int step) {
    ref.read(selectedStepProvider.notifier).state = step;
    scrollToIndex(step - 1);
  }

  /// Animates PageView to specific index and closes the drawer afterward
  void scrollToIndex(int index) {
    final controller = ref.read(pageControllerProvider);
    controller
        .animateToPage(
      index,
      duration: const Duration(milliseconds: 930),
      curve: Curves.easeInOut,
    )
        .then((_) {
      ref.read(drawerKeyProvider).currentState?.closeSlider();
      Future.delayed(const Duration(milliseconds: 400), () {
        ref.read(drawerStateProvider.notifier).state = false;
      });
    });
  }

  /// Delays and updates drawer open/close state
  void updateDrawerStateDelayed() {
    final isOpen =
        ref.read(drawerKeyProvider).currentState?.isDrawerOpen ?? false;
    Future.delayed(const Duration(milliseconds: 200), () {
      ref.read(drawerStateProvider.notifier).state = isOpen;
    });
  }
}
