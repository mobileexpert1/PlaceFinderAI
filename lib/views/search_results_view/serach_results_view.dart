import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../../providers/places_api_provider/place_service_provider.dart';
import '../../providers/search_view_provider/search_view_provider.dart';
import '../../utils/assets_path.dart';
import '../../utils/colors.dart';
import '../../utils/common.dart';
import '../../utils/fonts.dart';
import '../../utils/strings.dart';
import '../search_loading_view/search_loading_view.dart';
import 'custom_widgets/custom_widgets.dart';

/// Main page displaying search results with sliding drawer navigation.
/// Uses Riverpod for state management and async data fetching.
class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key});

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // Initialize selected step after first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedStepProvider.notifier).state = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch async places data and UI state providers
    final placeApiFetchList = ref.watch(placeListProvider);
    final selectedStep = ref.watch(selectedStepProvider);
    final controller = ref.watch(pageControllerProvider);
    final sliderDrawerKey = ref.watch(drawerKeyProvider);
    final isDrawerOpen = ref.watch(drawerStateProvider);

    // Controller for handling UI interactions
    final controllerHandler = SearchResultsController(ref);

    return Scaffold(
      backgroundColor: ColorRes.colorBackground,
      body: placeApiFetchList.when(
        // When data is ready, build UI with drawer and page view
        data: (placeData) => Listener(
          onPointerMove: (moveEvent) {
            // Delay drawer state update to avoid excessive calls during drag
            Future.delayed(const Duration(milliseconds: 300), () {
              controllerHandler.updateDrawerStateDelayed();
            });
          },
          child: Stack(
            children: [
              // Background decorative image
              Image.asset(CommonUi.setPngImage(AssetsPath.yellowEllipse)),

              // Slider drawer providing step navigation
              SliderDrawer(
                sliderOpenSize: 100,
                backgroundColor: Colors.transparent,
                key: sliderDrawerKey,
                slider: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  reverseDuration: Duration.zero,
                  switchInCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) {
                    // Fade and slide animation for drawer content changes
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  // Show drawer steps when open, otherwise show empty box
                  child: isDrawerOpen
                      ? AnimatedContainer(
                    key: const ValueKey('openDrawer'),
                    duration: const Duration(milliseconds: 800),
                    padding: const EdgeInsets.only(top: 140, bottom: 44),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      children: [
                        // Render step indicators with locked/unlocked states
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            placeData.length * 2 - 1,
                                (index) {
                              if (index.isEven) {
                                int stepIndex = index ~/ 2 + 1;
                                bool isUnlocked = stepIndex <= 4;

                                return GestureDetector(
                                  onTap: isUnlocked
                                      ? () => controllerHandler
                                      .onStepTapped(stepIndex)
                                      : null,
                                  child: AnimatedContainer(
                                    duration:
                                    const Duration(milliseconds: 400),
                                    curve: Curves.easeOut,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                        stepIndex == selectedStep
                                            ? 100
                                            : 4.47,
                                      ),
                                      border: Border.all(
                                        color: ColorRes.colorGreyDark,
                                        width: stepIndex == selectedStep
                                            ? 1.6
                                            : 1.2,
                                      ),
                                    ),
                                    // Display step number or lock icon based on unlock state
                                    child: isUnlocked
                                        ? Text(
                                      stepIndex
                                          .toString()
                                          .padLeft(2, '0'),
                                      style: TextStyle(
                                        color: stepIndex ==
                                            selectedStep
                                            ? Colors.black
                                            : ColorRes
                                            .colorGreyDark,
                                        fontFamily: Fonts.extraBold,
                                      ),
                                    )
                                        : Image.asset(
                                      CommonUi.setPngImage(
                                          AssetsPath.lock),
                                      scale: 2,
                                    ),
                                  ),
                                );
                              } else {
                                // Separator line between steps
                                return Container(
                                  width: 2,
                                  height: 30,
                                  color: Colors.black,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                      : const SizedBox(key: ValueKey('closedDrawer')),
                ),
                appBar: const SizedBox(),

                // Main content with AppBar and vertical PageView for places
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // Transparent AppBar with custom styled title
                        AppBar(
                          surfaceTintColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          centerTitle: true,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: StringRes.placeTxt,
                                      style: TextStyle(
                                        fontFamily: Fonts.extraBold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: StringRes.finderTxt,
                                      style: TextStyle(
                                        fontFamily: Fonts.medium,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: StringRes.aiTxt,
                                      style: TextStyle(
                                        fontFamily: Fonts.extraBold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // PageView showing place cards with vertical scroll
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24)),
                            ),
                            child: PageView.builder(
                              controller: controller,
                              itemCount: placeData.length,
                              scrollDirection: Axis.vertical,
                              onPageChanged: (value) {
                                // Update selected step on page change
                                ref.read(selectedStepProvider.notifier).state =
                                    value + 1;
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child:
                                  placesCardWidget(place: placeData[index]),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Show loading indicator while fetching data
        loading: () => const SearchLoadingView(),

        // Show error message on failure
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
