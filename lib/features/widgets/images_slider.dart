import 'package:final_project/cores/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailedSlider extends StatefulWidget {
  const DetailedSlider({super.key, required this.images});
  final List<String> images;
  @override
  State<DetailedSlider> createState() => _DetailedSliderState();
}

class _DetailedSliderState extends State<DetailedSlider> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: CarouselSlider(
            items: widget.images.map((url) {
              return Image.network(
                url,
                width: double.infinity,
                height: 401,
                fit: BoxFit.scaleDown,
                errorBuilder: (_, _, _) =>
                const Center(child: Icon(Icons.image_not_supported)),
              );
            }).toList(),
            options: CarouselOptions(
              height: 401,
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
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
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
