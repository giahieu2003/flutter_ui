import 'package:app_shop/controllers/cart_provider.dart';
import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/shared/checkout_btn.dart';
import 'package:app_shop/views/ui/mainscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: const Icon(
                //     AntDesign.close,
                //     color: Colors.black,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: cartProvider.cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cartProvider.cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: const Offset(0, 1)),
                                  ]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: CachedNetworkImage(
                                              imageUrl: data['imageUrl'],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                              bottom: -2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  cartProvider
                                                      .deleteCart(data['key']);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainScreen()));
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      12))),
                                                  child: const Icon(
                                                    AntDesign.delete,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: appstyle(15, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data['category'],
                                              style: appstyle(12, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${data['price']}",
                                                  style: appstyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 40,
                                                ),
                                                Text(
                                                  "Size   ${data['sizes']}",
                                                  style: appstyle(
                                                      16,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    cartProvider.decrement(data['key']);
                                                  },
                                                  child: const Icon(
                                                    AntDesign.minussquare,
                                                    size: 20,
                                                    color: Colors.grey,
                                                  )),
                                              Text(
                                                data['qty'].toString(),
                                                style: appstyle(
                                                  16,
                                                  Colors.black,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    cartProvider.increment(data['key']);
                                                  },
                                                  child: const Icon(
                                                    AntDesign.plussquare,
                                                    size: 20,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),


                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: "Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
