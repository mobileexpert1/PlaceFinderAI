import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:placefinderai/views/welcome_view/welcome_view.dart';
import '../../providers/welcome_view_provider/welcome_view_provider.dart';
import '../../utils/assets_path.dart';
import '../../utils/colors.dart';
import '../../utils/common.dart';
import '../../utils/fonts.dart';
import '../../utils/navigator.dart';

/// Splash screen displaying animated welcome text with logo.
/// After fixed delay, navigates to WelcomeScreen.
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    // Delay navigation to WelcomeScreen after 5.5 seconds
    Future.delayed(const Duration(milliseconds: 5500)).then(
          (value) => mounted
          ? Navigator.push(
        context,
        NavigatorService().createRoute(page: const WelcomeScreen()),
      )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch provider for current animated splash text
    final splashState = ref.watch(welcomeTextControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildAnimatedTitle(splashState.currentText),
    );
  }

  /// Builds animated splash title with text and decorative yellow circle
  Widget _buildAnimatedTitle(String text) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),

          // Animated splash text
          Text(
            text,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontFamily: Fonts.medium,
            ),
          ),

          const SizedBox(width: 8),

          // Yellow circle image with shadow for branding effect
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: ColorRes.colorBackground,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset(
              CommonUi.setPngImage(AssetsPath.circleYellow),
              scale: 2,
            ),
          ),
        ],
      ),
    );
  }
}
