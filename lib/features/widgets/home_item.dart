import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:flutter/material.dart';


class HomeItem extends StatefulWidget {
  const HomeItem({
    super.key,
    required this.title,
    required this.image,
    required this.price,
  });

  final String title;
  final String image;
  final double price;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 143,
      width: 126,
      decoration: BoxDecoration(
        color: Color(0xffF8F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Image.network(widget.image, height: 99, width: 126, fit: BoxFit.scaleDown,),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFav = !isFav;
                      });
                    },
                    child: Icon(isFav ? Icons.favorite_sharp : Icons.favorite_border_sharp, color: isFav ? Colors.red : Colors.white, size: 35,)
                  ),
                )
              ]
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  widget.title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
                Text(
                  "\$${widget.price}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
