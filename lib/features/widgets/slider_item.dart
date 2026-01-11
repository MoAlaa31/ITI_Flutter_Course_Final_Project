import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/features/widgets/discount_banner_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;

  final List<Widget> banners = [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: discountBanner(
        title: "Get Winter Discount",
        discount: "20% Off",
        subtitle: "For Children",
        image: AppImage.homeImage,
        color: AppColors.primaryColor,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: discountBanner(
        title: "Get Winter Discount",
        discount: "20% Off",
        subtitle: "For Children",
        image: AppImage.homeImage,
        color: Colors.red,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: discountBanner(
        title: "Get Winter Discount",
        discount: "20% Off",
        subtitle: "For Children",
        image: AppImage.homeImage,
        color: Colors.green,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: discountBanner(
        title: "Get Winter Discount",
        discount: "20% Off",
        subtitle: "For Children",
        image: AppImage.homeImage,
        color: Colors.yellow,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: banners.map((banner) => banner).toList(),
          options: CarouselOptions(
            height: 135,
            autoPlay: true,
            viewportFraction: 1,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primaryColor
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
