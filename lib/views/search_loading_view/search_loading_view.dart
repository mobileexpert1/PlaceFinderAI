import 'package:flutter/material.dart';
import '../../utils/assets_path.dart';
import '../../utils/colors.dart';
import '../../utils/common.dart';
import '../../utils/fonts.dart';
import '../../utils/strings.dart';

/// Displays a placeholder UI while a search is in progress.
class SearchLoadingView extends StatelessWidget {
  const SearchLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBackground,
      // App background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Center content vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          // Center content horizontally
          children: [
            // Search placeholder image
            Image.asset(
              CommonUi.setPngImage(AssetsPath.searchPlaceHolder),
              scale: 2,
            ),

            // Main "Searching..." text
            const Text(
              StringRes.searchingTxt,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 25,
                fontFamily: Fonts.semiBold,
              ),
            ),

            // Subtext under main searching message
            const Text(
              StringRes.searchSubTxt,
              style: TextStyle(
                color: ColorRes.colorGreyDark,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: Fonts.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}