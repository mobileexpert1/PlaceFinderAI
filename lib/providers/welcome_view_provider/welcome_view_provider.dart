import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:placefinderai/providers/welcome_view_provider/welcome_view_state.dart';

/// Provides a state notifier for animated welcome text
final welcomeTextControllerProvider =
StateNotifierProvider<WelcomeTextController, WelcomeTextState>(
      (ref) => WelcomeTextController(),
);

/// Controls the animated typewriter effect for welcome text
class WelcomeTextController extends StateNotifier<WelcomeTextState> {
  WelcomeTextController() : super(WelcomeTextState.initial()) {
    _animateLine(); // Start the animation loop
  }

  /// Lines of text to cycle through
  final List<String> _lines = ["Place Finder AI ", "Let's find places "];

  /// Manages typing and deleting animation
  Future<void> _animateLine() async {
    while (true) {
      final fullLine = _lines[state.currentLineIndex];

      if (!state.isDeleting) {
        // Typing characters one by one
        if (state.currentLetterIndex < fullLine.length) {
          await Future.delayed(const Duration(milliseconds: 80));
          state = state.copyWith(
            currentText: state.currentText + fullLine[state.currentLetterIndex],
            currentLetterIndex: state.currentLetterIndex + 1,
          );
        } else {
          // Pause before starting to delete
          await Future.delayed(const Duration(seconds: 1));
          state = state.copyWith(isDeleting: true);
        }
      } else {
        // Deleting characters one by one
        if (state.currentLetterIndex > 0) {
          await Future.delayed(const Duration(milliseconds: 40));
          state = state.copyWith(
            currentText:
            state.currentText.substring(0, state.currentText.length - 1),
            currentLetterIndex: state.currentLetterIndex - 1,
          );
        } else {
          // Switch to next line after deleting
          state = state.copyWith(
            isDeleting: false,
            currentLineIndex: (state.currentLineIndex + 1) % _lines.length,
          );
        }
      }
    }
  }
}
