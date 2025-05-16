/// State class for managing animated welcome text
class WelcomeTextState {
  final String currentText;         // Currently displayed text
  final int currentLineIndex;       // Index of the line being animated
  final int currentLetterIndex;     // Index of the next letter to type/delete
  final bool isDeleting;            // Indicates whether text is being deleted

  WelcomeTextState({
    required this.currentText,
    required this.currentLineIndex,
    required this.currentLetterIndex,
    required this.isDeleting,
  });

  /// Returns a new state with updated fields
  WelcomeTextState copyWith({
    String? currentText,
    int? currentLineIndex,
    int? currentLetterIndex,
    bool? isDeleting,
  }) {
    return WelcomeTextState(
      currentText: currentText ?? this.currentText,
      currentLineIndex: currentLineIndex ?? this.currentLineIndex,
      currentLetterIndex: currentLetterIndex ?? this.currentLetterIndex,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  /// Initial/default state setup
  static WelcomeTextState initial() {
    return WelcomeTextState(
      currentText: '',
      currentLineIndex: 0,
      currentLetterIndex: 0,
      isDeleting: false,
    );
  }
}
