import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:placefinderai/utils/colors.dart';
import '../../../models/model.dart';
import '../../../utils/fonts.dart';
import '../../../utils/strings.dart';

/// Widget to display a styled card for a place
Widget placesCardWidget({required Place place}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title section with serial number and title
          Row(
            children: [
              // Serial number badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF6C812), Color(0xFFFFA600)],
                  ),
                  borderRadius: BorderRadius.circular(4.2),
                ),
                child: Text(
                  place.serialNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.semiBold,
                    fontSize: 14.29,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Place title
              Text(
                place.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: Fonts.extraBold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description text
          Text(
            place.description,
            style: const TextStyle(
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
              color: Colors.black87,
              fontFamily: Fonts.regular,
              wordSpacing: 1,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
            maxLines: 7,
          ),
          const SizedBox(height: 10),

          // Rating bar with stars and review count
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: ColorRes.colorLightYellow),
            child: Row(
              children: [
                const Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.medium,
                  ),
                ),
                const Spacer(),
                // Static 3.5 star rating
                ...List.generate(3, (_) => const Icon(Icons.star, color: Colors.orange, size: 16)),
                const Icon(Icons.star_half, color: Colors.orange, size: 16),
                const Spacer(flex: 3),
                // Review count
                Text(
                  place.review,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.medium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Image gallery widget
          CustomPizzaGallery(imageUrls: place.imageList),
          const SizedBox(height: 20),

          // Buttons: View Details and Show Map
          Row(
            children: [
              // Outlined button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 51,
                    child: const Text(
                      StringRes.viewDetailsTxt,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: Fonts.medium,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Gradient-filled button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF6C812), Color(0xFFFFA600)],
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 51,
                      child: const Text(
                        StringRes.showMapTxt,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: Fonts.medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// Widget to display up to 4 place images, with overlay if more exist
class CustomPizzaGallery extends StatelessWidget {
  final List<String> imageUrls;

  const CustomPizzaGallery({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final totalImages = imageUrls.length;
    final displayImages = imageUrls.take(4).toList(); // Limit to 4 images max

    return Column(
      children: [
        // Main large image
        if (displayImages.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => const Icon(
                size: 80,
                Icons.error,
                color: ColorRes.colorYellow,
              ),
              imageUrl: displayImages[0],
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(height: 8),

        // Thumbnails below main image
        if (displayImages.length > 1)
          Row(
            children: List.generate(displayImages.length - 1, (index) {
              final imageIndex = index + 1;
              final isLastImage = imageIndex == 4 && totalImages > 5;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    children: [
                      // Thumbnail image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: displayImages[imageIndex],
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Overlay "+N" if more images exist
                      if (isLastImage)
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "+${totalImages - 4}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }
}
