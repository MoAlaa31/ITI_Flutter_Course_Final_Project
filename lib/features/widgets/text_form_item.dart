import 'package:final_project/cores/resources/app_colors.dart';
import 'package:flutter/material.dart';


class TextFormItem_ extends StatefulWidget {
  const TextFormItem_({
    super.key,
    required this.isPassword,
    required this.hintText,
    required this.label,
    this.controller
  });
  final bool isPassword;
  final String hintText;
  final String label;
  final TextEditingController? controller;

  @override
  State<TextFormItem_> createState() => _TextFormItem_State();
}

class _TextFormItem_State extends State<TextFormItem_> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? isHidden : false,
          decoration: InputDecoration(
            filled: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: widget.isPassword
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                child: isHidden
                    ? Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                )
                    : Icon(
                  Icons.visibility_off,
                  color: Colors.black,
                ),
              )
                  : SizedBox.shrink(),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE6E6E6)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffBFB8B8)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            // labelText: widget.label,
            // labelStyle: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color(0xff000000).withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.3
            ),
          ),
        ),
      ],
    );
  }
}