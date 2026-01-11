import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/cores/resources/snack_bar.dart';
import 'package:final_project/features/cart/cart_cubit.dart';
import 'package:final_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: Image.network(widget.model.thumbnail ?? "", height: double.infinity, width: double.infinity, fit: BoxFit.scaleDown,),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.model.title ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      Text(
                        "\$${widget.model.price ?? 0.0}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showMySnackBar(
                      msg: "Item Added to Cart",
                      type: AnimatedSnackBarType.info,
                      context: context,
                    );
                    context.read<CartCubit>().addToCart(widget.model);
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: AppColors.primaryColor,
                    size: 26,
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
