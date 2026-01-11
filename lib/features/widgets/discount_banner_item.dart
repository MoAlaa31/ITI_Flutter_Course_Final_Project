import 'package:flutter/material.dart';

Widget discountBanner({
  required String title,
  required String discount,
  required String subtitle,
  required String image,
  required Color color,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      height: 140,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "\n$discount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "\n$subtitle",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 89,
            height: 135,
            child: Image.asset(
              image,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    ),
  );
}
