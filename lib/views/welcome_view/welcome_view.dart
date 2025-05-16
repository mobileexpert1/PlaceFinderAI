import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/welcome_view_provider/welcome_view_provider.dart';
import '../../utils/assets_path.dart';
import '../../utils/colors.dart';
import '../../utils/common.dart';
import '../../utils/fonts.dart';
import '../../utils/navigator.dart';
import '../../utils/strings.dart';
import '../search_results_view/serach_results_view.dart';

/// Welcome screen showing header, animated welcome text, suggestion cards, and search bar.
/// Uses Riverpod to watch animated text state.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to animated welcome text state
    final welcomeState = ref.watch(welcomeTextControllerProvider);

    return Scaffold(
      backgroundColor: ColorRes.colorBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Top header with menu, logo, and profile avatar
            _buildHeader(),

            const Spacer(),

            // Animated welcome text with decorative circle
            _buildAnimatedTitle(welcomeState.currentText),

            const Spacer(),

            // Suggestion cards offering quick options
            _buildSuggestionCards(),

            const SizedBox(height: 20),

            // Search bar with input field, distance tag, mic, and send button
            _buildSearchBar(context),
          ],
        ),
      ),
    );
  }

  /// Header row with menu icon, app logo, and user avatar
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(CommonUi.setPngImage(AssetsPath.menu), scale: 1),
          Image.asset(CommonUi.setPngImage(AssetsPath.placeFinderAi), scale: 2),
          Image.asset(CommonUi.setPngImage(AssetsPath.profileAvatar), scale: 1),
        ],
      ),
    );
  }

  /// Animated welcome text with yellow circle highlight
  Widget _buildAnimatedTitle(String text) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
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

  /// Row containing two suggestion cards for quick place searches
  Widget _buildSuggestionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildCard(
              title: StringRes.fastFoodTitle,
              subtitle: StringRes.fastFoodSubtitle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCard(
              title: StringRes.atmsNearMeTitle,
              subtitle: StringRes.atmsNearMeSubtitle,
            ),
          ),
        ],
      ),
    );
  }

  /// Individual suggestion card with title and subtitle styling
  Widget _buildCard({required String title, required String subtitle}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorRes.colorGreyLight),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: Fonts.regular,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: Fonts.regular,
              fontWeight: FontWeight.w400,
              color: ColorRes.colorGreyDark,
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom search bar with text input, location distance tag, mic icon, and send button
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorRes.colorGreyLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 1.2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Search input field with placeholder text
            TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: StringRes.findPlaceHintTxt,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: Fonts.regular,
                  fontSize: 16,
                  color: ColorRes.colorGreyDark,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Row containing distance tag, mic, and send button
            Row(
              children: [
                // Distance tag with icon and label
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorRes.colorGreyDark),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.directions_walk, size: 20),
                      SizedBox(width: 4),
                      Text(
                        "1.5 km",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: Fonts.regular,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Microphone icon for voice input
                Image.asset(CommonUi.setPngImage(AssetsPath.mic), scale: 2),

                const SizedBox(width: 16),

                // Send button navigates to SearchResultsPage on tap
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      NavigatorService()
                          .createRoute(page: const SearchResultsPage()),
                    );
                  },
                  child: Image.asset(CommonUi.setPngImage(AssetsPath.send),
                      scale: 2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
