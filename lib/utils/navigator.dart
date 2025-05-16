import 'package:flutter/cupertino.dart';

/// Service to create custom page route transitions
class NavigatorService {
  /// Creates a route with a slide-in-from-right animation
  Route createRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Animation starts from right side
        const end = Offset.zero;         // Ends at original position
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        // Slide transition for the page route
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
