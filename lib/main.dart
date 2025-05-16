import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placefinderai/utils/strings.dart';
import 'package:placefinderai/views/splash_view/splash_view.dart';

void main() {
  /// Entry point of the app, wrapping with Riverpod ProviderScope for state management
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      debugShowCheckedModeBanner:
          false, // Remove debug banner for release builds
      title: StringRes
          .placeFinderAiTxt, // App title from centralized string resources
      home: const SplashView(), // Initial screen shown on app launch
    );
  }
}
