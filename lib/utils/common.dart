/// Helper class for generating asset image paths dynamically
class CommonUi {
  /// Returns the path for an SVG image asset given its base name
  static String setSvgImage(String image) {
    return 'assets/svg/$image.svg';
  }

  /// Returns the path for a PNG image asset given its base name
  static String setPngImage(String image) {
    return 'assets/png/$image.png';
  }
}
