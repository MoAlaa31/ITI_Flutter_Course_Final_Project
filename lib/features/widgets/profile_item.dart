import 'package:final_project/cores/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.text, required this.icon});
  final text;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffF8F7F7)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 25,)
            ],
          ),
        ),
      ),
    );
  }
}
