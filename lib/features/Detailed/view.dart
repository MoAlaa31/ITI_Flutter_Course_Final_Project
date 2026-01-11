import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/cores/resources/snack_bar.dart';
import 'package:final_project/features/cart/cart_cubit.dart';
import 'package:final_project/features/widgets/images_slider.dart';
import 'package:final_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailedPage extends StatelessWidget {
  const DetailedPage({super.key, required this.model});

  final ProductModel model;
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final List<String> imageList =
    (model.images != null && model.images!.isNotEmpty)
        ? model.images!
        : [model.thumbnail ?? ""];

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            width: 48,
            height: 48,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: const Color(0xffD3D0D0),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 68,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xffD3D0D0),
              child: Icon(
                Icons.favorite_outlined,
                color: Color(0xff7C7979),
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.only(
                      //     bottomLeft: Radius.circular(10),
                      //     bottomRight: Radius.circular(10),
                      //   ),
                      //   child: Image.network(
                      //     model.thumbnail ?? "",
                      //     height: 401,
                      //     width: double.infinity,
                      //     fit: BoxFit.scaleDown,
                      //   ),
                      // ),
                      DetailedSlider(images: imageList,),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.title ?? "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Icon(Icons.star_outlined, size: 26, color: Color(0xffFFC107),),
                                    Text(
                                      "${model.rating} ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "( ${model.reviewsCount} Review)",
                                      style: TextStyle(
                                        color: Color(0xff7D7A7A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "\$${model.price ?? 0.0}",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 18,),
                      Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        model.description ?? "",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.subColor,
                        ),
                      ),
                      SizedBox(height: 24,),
                      Text(
                        "Size",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        spacing: 10,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              border: BoxBorder.all(width: 1, color: Color(0xffCFCDCD)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "8",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              border: BoxBorder.all(width: 1, color: Color(0xffCFCDCD)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "10",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              border: BoxBorder.all(width: 1, color: Color(0xffCFCDCD)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "38",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              border: BoxBorder.all(width: 1, color: Color(0xffCFCDCD)),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "40",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      flex: 27,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          // => cubit.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Buy Now",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: (){
                              showMySnackBar(
                                msg: "Item Added to Cart",
                                type: AnimatedSnackBarType.info,
                                context: context,
                              );
                              context.read<CartCubit>().addToCart(model);
                          },
                          // => cubit.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF8F7F7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: SvgPicture.asset(AppImage.bagIcon)
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: statusBarHeight,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
