import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shopx/animation/fade_Animaton.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/models/product.dart';
import 'package:shopx/screens/order/order_New.dart';
import 'package:shopx/state/cart_Getx.dart';

class Cart extends StatefulWidget {
  static const routename = '/cart_screen';
  final bool? check; // true cancel back

  const Cart({super.key, required this.check});

  @override
  State<Cart> createState() => _CartState();
}

// final Cartx cartx = Get.find();
final Cartx cartx2 = Get.put(Cartx());

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                FadeAnimation(
                    .2,
                    Container(
                      width: w * 0.980,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.check == true
                              ? SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_rounded),
                                  splashColor: AppColors.primary,
                                  splashRadius: 25,
                                ),
                          const Text(
                            "My Cart",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          // dleate all or cleare all product in cart
                          IconButton(
                            onPressed: () {
                              cartx2.clear();
                            },
                            icon: const Icon(Icons.delete_outline_rounded),
                            splashColor: Colors.deepOrange,
                            splashRadius: 25,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: h * 0.01,
                ),
                cartx2.count == 0
                    ? const Center(
                        child: Text(
                          "Cart is empty try to add some product!",
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            height: widget.check == true ? h * 0.6 : h * 0.7,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: cartx2.cartItems.length,
                                itemBuilder: (ctx, index) => Column(
                                      children: [
                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        FadeAnimation(
                                            .3,
                                            CardproductCart(
                                                cart: cartx2,
                                                product: cartx2.cartItems.keys
                                                    .toList()[index],
                                                quantity: cartx2
                                                    .cartItems.values
                                                    .toList()[index],
                                                index: index))
                                      ],
                                    )),
                          ),
                          Carttotal(
                            cart: cartx2,
                          )
                        ],
                      )
              ],
            ),
          )),
        ));
  }
}

class CardproductCart extends StatefulWidget {
  final Cartx cart;
  final Product product;
  final int quantity;
  final int index;

  const CardproductCart(
      {super.key,
      required this.cart,
      required this.product,
      required this.quantity,
      required this.index});

  @override
  State<CardproductCart> createState() => _CardproductCartState();
}

bool isChecked = false;

class _CardproductCartState extends State<CardproductCart> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Slidable(
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (_) => widget.cart.deletproducts(widget.product),
            backgroundColor: const Color.fromARGB(255, 250, 167, 34),
            foregroundColor: Colors.black,
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
          )
        ]),
        child: Center(
          child: Container(
            width: w * 0.917,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(width: 1, color: Colors.grey.withOpacity(.5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Checkbox(
                    splashRadius: 28,
                    value: isChecked,
                    activeColor: const Color.fromARGB(255, 250, 167, 34),
                    onChanged: (bool? val) {
                      setState(() {
                        isChecked = val!;
                      });
                    }),
                Container(
                  width: w * 0.795,
                  height: h * 0.123,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w * 0.145,
                          height: h * 0.082,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'http://10.0.2.2:8000${widget.product.img}'))),
                        ),
                        SizedBox(
                          width: w * 0.0226,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${widget.product.titel}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${widget.product.sellingPrice}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        // decrease produkt
                        IconButton(
                            onPressed: () {
                              widget.cart.deletproduct(widget
                                  .product); // if val == 1 delet all else -1
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.black54,
                            )),

                        Text("${widget.quantity}"),

                        IconButton(
                            onPressed: () {
                              widget.cart.addproduct(
                                  widget.product); // same product well add
                            },
                            icon: const Icon(Icons.add_circle,
                                color: AppColors.primary)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class Carttotal extends StatefulWidget {
  final Cartx cart;

  const Carttotal({super.key, required this.cart});

  @override
  State<Carttotal> createState() => _CarttotalState();
}

class _CarttotalState extends State<Carttotal> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Card(
      child: Column(
        children: [
          SizedBox(
            height: h * 0.0129,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Total Payment",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text(
                '\$${widget.cart.total}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.0258,
          ),
          InkWell(
            onTap: () {
              List<String> x = [];
              for (var i = 0; i < widget.cart.cartItems.length; i++) {
                x.add(
                    'product-Id : ${widget.cart.cartItems.keys.toList()[i].id} Quantity : ${widget.cart.cartItems.values.toList()[i]} ');
              }

              // for (String item in x) {
              //   // تقسيم النص بناءً على الفاصلة بين الأجزاء (":")
              //   List<String> parts = item.split('Quantity');
              //   String productId =
              //       parts[0].trim(); // "pid : vvv" أو "pid : mmm"
              //   String quantity = parts[1].trim(); // "1" أو "2"

              //   print('Product ID: $productId');
              //   print('Quantity: $quantity');
              // }

              // print(x); // all list
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          OrderScreen(total: '${widget.cart.total}', item: x)),
                  (route) => true);
            },
            child: Container(
              height: h * 0.072,
              width: w * 0.795,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text(
                  "Checkout Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
