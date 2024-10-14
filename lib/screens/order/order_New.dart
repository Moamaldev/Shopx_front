import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/order/payment_withCard.dart';
import 'package:shopx/state/cart_Getx.dart';
import 'package:shopx/state/fetch_Singel_user.dart';
import 'package:shopx/state/order_State.dart';
import 'package:shopx/style.dart';
import 'package:shopx/widgets/bottomBar.dart';

class OrderScreen extends StatefulWidget {
  final String total;
  final List<String> item;

  const OrderScreen({super.key, required this.total, required this.item});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

final Cartx cartx = Get.find();

class _OrderScreenState extends State<OrderScreen> {
  String _email = '';
  String _phone = '';
  String _address = '';
  // String _username = '';
  final _form = GlobalKey<FormState>();
  void ordernew() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState?.save();
    final uid = Provider.of<FetchSingelUser>(context, listen: false).user?.id;

    List<Map<String, dynamic>> products = []; // قائمة المنتجات بشكل Map

    for (String item in widget.item) {
      List<String> parts = item.split('Quantity');

      if (parts.length == 2) {
        String productIdx = parts[0].trim(); // productId
        String quantityx = parts[1].trim(); // quantity

        String quantityString = quantityx.split(':').last.trim();

        // print('Product ID: $productIdx');
        // print('Quantity: $quantityString');

        products.add({
          "productId": productIdx,
          "quantity": quantityString,
        });
      } else {
        print('Error: Invalid format for item: $item');
      }
    }
    bool orderDone = await Provider.of<OrderState>(context, listen: false)
        .newOrder(
            widget.total, _email, _phone, _address, 'Cash', uid!, products);
    if (orderDone) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: 'Congratulations',
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 20,
                ),
                // PrimaryText(
                //   text: 'Welcome to Shopx $_first_name',
                //   size: 14,
                // ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(BottomBar.routename);
                    cartx.clear();
                  },
                  child: Text('Done'))
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: 'Somthing is Wrong Try Again',
                  size: 16,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        },
      );
    }

    // bool order = await Provider.of<OrderState>(context, listen: false).orderNow(
    //     address: _address,
    //     email: _email,
    //     phone: _phone,
    //     products_list: widget.item,
    //     uid: uid,
    //     total: widget.total,
    //     payment_method: 'Cash');

    // if (order) {
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (ctx) => const OrderHistory()),
    //       (route) => false);
    //   cartx.clear();
    // }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Now',
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
              key: _form,
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.02,
                  ),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Your Email';
                      } else if (!v.contains('@') || !v.contains('.com')) {
                        return 'Use a correct Email';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      _email = v!;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: AppColors.primary.withOpacity(.1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Colors.deepOrange.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintStyle: const TextStyle(fontSize: 16),
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.deepOrange,
                      ),
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Your phone number';
                      } else if (v.length <= 9) {
                        return 'Use a correct phone number';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      _phone = v!;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: AppColors.primary.withOpacity(.1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Colors.deepOrange.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintStyle: const TextStyle(fontSize: 16),
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.phone_android_outlined,
                        color: Colors.deepOrange,
                      ),
                      hintText: "Phone",
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Your Address';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (v) {
                      _address = v!;
                    },
                    //  textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: AppColors.primary.withOpacity(.1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Colors.deepOrange.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintStyle: const TextStyle(fontSize: 16),
                      border: InputBorder.none,
                      icon: const Icon(
                        Icons.location_city_outlined,
                        color: Colors.deepOrange,
                      ),
                      hintText: "Address",
                    ),
                  ),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        // make order
                        onPressed: () {
                          ordernew();

// طباعة قائمة المنتجات للتأكد من تنسيقها

// إنشاء كائن order
//                           order orderx = order(
//                             productsList:
//                                 products, // تأكد من أن productsList يقبل List<Map<String, dynamic>>
//                             total: widget.total,
//                             email: _email,
//                             phone: _phone,
//                             address: _address,
//                             paymentMethod: "cash",
//                             user: uidt,
//                           );

// // طباعة بيانات الطلب في تنسيق JSON
//                           print('Order JSON: ${jsonEncode(orderx.toJson())}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),

                        child: const Text(
                          'Cash On Delivery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Edit Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  // another page
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => PaymentWithcard(
                                  total: widget.total, item: widget.item)),
                          (route) => true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 167, 98, 242),
                    ),
                    label: const Text(
                      'Payment with Credit Card',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.credit_card,
                      color: Colors.black,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
