import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/cores/resources/app_images.dart';
import 'package:final_project/features/cart/cart_cubit.dart';
import 'package:final_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.model
  });
  final ProductModel model;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: BoxBorder.all(
            color: Color(0xffE6E6E6),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 83,
              height: 79,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  widget.model.thumbnail ?? "",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              width: 213,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          widget.model.title ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          context.read<CartCubit>().removeFromCart(widget.model);
                        },
                          child: Icon(Icons.delete, color: Color(0xffED1010),))
                    ],
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    "Size L",
                    style: TextStyle(
                      color: AppColors.subColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 18.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${widget.model.price ?? 0.0}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if(counter <= 0){
                                    return;
                                  }
                                  counter--;
                                });
                              },
                              child: Container(
                                width: 23.75,
                                height: 22.37,
                                decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      color: Color(0xffE6E6E6),
                                      width: 0.64,
                                    ),
                                    borderRadius: BorderRadius.circular(3)
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                            Text(
                              "$counter",
                              // "2",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  counter++;
                                });
                              },
                              child: Container(
                                width: 23.75,
                                height: 22.37,
                                decoration: BoxDecoration(
                                    border: BoxBorder.all(
                                      color: Color(0xffE6E6E6),
                                      width: 0.64,
                                    ),
                                    borderRadius: BorderRadius.circular(3)
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
