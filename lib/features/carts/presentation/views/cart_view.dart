// ignore: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thepos/features/carts/data/models/cart_item.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/widgets/cart_item_product_widget.dart';
import 'package:thepos/features/carts/presentation/widgets/cart_item_widget.dart';

final cartsController = Get.put(CartsController());

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() => Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            color: Colors.white,
            // height: 100,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cartsController.listCarts.map((cart) {
                      final index = cartsController.listCarts.indexOf(cart);

                      return GestureDetector(
                          onTap: () {
                            cartsController.changeCart(index);
                          },
                          child: CartItemWidget(
                              title: cart.keyCart,
                              isSelected: cartsController.selectedCart !=
                                      null &&
                                  cartsController.selectedCart.value == index));
                    }).toList(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffF79624),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      // color: const Color(0xff178F49) ,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "زائر - ١٠٠",
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Color(0xffF79624),
                        size: 30,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/edit.svg",
                      width: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'السلة ',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          // style: TextStyle(
                          //   fontFamily: 'Cairo',
                          //   fontSize: 30,
                          //   color: const Color(0xff000000),
                          //   fontWeight: FontWeight.w600,
                          // ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0)),
                            color: Color(0xff178f49),
                          ),
                          child: Text(
                            '${cartsController.listCarts[cartsController.selectedCart.value].cartItems.length}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 20,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/svg/delet.svg",
                      width: 25,
                    ),
                  ],
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartsController
                  .listCarts[cartsController.selectedCart.value]
                  .cartItems
                  .length,
                  itemBuilder: (BuildContext context, int index) {
                CartItem item = cartsController
                    .listCarts[cartsController.selectedCart.value]
                    .cartItems[index];
                return CartItemProductWidget(
                  item: item,
                  refresh: (){
                    setState(() {

                    });
                  },
                );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                return const Divider();
                  },
                )
              ],
            ),
          ))),
    );
  }
}
