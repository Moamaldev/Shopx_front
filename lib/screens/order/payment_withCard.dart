import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/state/cart_Getx.dart';
import 'package:shopx/state/fetch_Singel_user.dart';
import 'package:shopx/state/order_State.dart';
import 'package:shopx/style.dart';
import 'package:shopx/widgets/bottomBar.dart'; // إضافة المكتبة

class PaymentWithcard extends StatefulWidget {
  final String total;
  final List<String> item;

  const PaymentWithcard({super.key, required this.total, required this.item});
  @override
  _PaymentWithcardState createState() => _PaymentWithcardState();
}

final Cartx cartx = Get.find();

class _PaymentWithcardState extends State<PaymentWithcard> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderNameController = TextEditingController();

  // لتنسيق رقم البطاقة
  String get formattedCardNumber {
    String cardNumber = _cardNumberController.text.replaceAll(' ', '');
    return cardNumber.isEmpty
        ? ''
        : cardNumber.replaceAllMapped(
            RegExp(r'(\d{4})(?=\d)'), (match) => '${match.group(0)} ');
  }

  // للتحقق من صحة تاريخ انتهاء البطاقة
  bool isValidExpiryDate(String value) {
    if (!RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
      return false; // تنسيق غير صالح
    }

    // التحقق من التاريخ الفعلي
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(parts[1]) + 2000; // تحويل السنة إلى 4 أرقام

    final expiryDate = DateTime(year, month);

    // التاريخ يجب أن يكون أكبر من التاريخ الحالي
    return expiryDate.isAfter(DateTime.now());
  }

  final cardDecoration = const BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
      ],
      gradient: LinearGradient(
          colors: [Color(0xFFA95EFA), Colors.orangeAccent],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
      borderRadius: BorderRadius.all(Radius.circular(15)));
  final buttonTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);

  bool type = false;

  // work space
  String _email = '';
  String _phone = '';
  String _address = '';
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
        .newOrder(widget.total, _email, _phone, _address, 'CridetCard', uid!,
            products);
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
          'E-Payment',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // عرض البطاقة
            Container(
              width: double.infinity,
              height: h * 0.22,
              padding: EdgeInsets.all(16),
              decoration: cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // img

                  formattedCardNumber.isEmpty
                      ? SizedBox(height: h * 0.016)
                      : type == true
                          ? Image.asset(
                              'assets/visacard.png',
                              height: 30,
                              width: 30,
                            )
                          : Image.asset(
                              'assets/mastercard.png',
                              height: 30,
                              width: 30,
                            ),

                  Center(
                    child: Text(
                      formattedCardNumber,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: h * 0.016),
                  Text(
                    'Card Holder: ${_cardHolderNameController.text}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: h * 0.035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expiry: ${_expiryDateController.text}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        'CVV: ${_cvvController.text}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            // النموذج لإدخال تفاصيل البطاقة

            Container(
              width: double.infinity,
              height: h * 0.51,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _cardNumberController,
                            decoration: InputDecoration(
                              labelText: 'Card Number',
                              hintText: '1234 5678 9012 3456',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 16, // 16 رقم + 3 مسافات
                            inputFormatters: [
                              // تنسيق الإدخال لرقم البطاقة
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9 ]')),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your card number';
                              }
                              if (value.replaceAll(' ', '').length != 16) {
                                return 'Card number must be 16 digits';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {}); // تحديث عرض رقم البطاقة
                              if (value.startsWith('4')) {
                                setState(() {
                                  type = true;
                                });
                              } else {
                                setState(() {
                                  type = false;
                                });
                              }
                            },
                          ),
                          TextFormField(
                            controller: _cardHolderNameController,
                            decoration: InputDecoration(
                              labelText: 'Card Holder Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter card holder\'s name';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {}); // تحديث عرض name البطاقة
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _expiryDateController,
                                  decoration: InputDecoration(
                                    labelText: 'Expiry Date (MM/YY)',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter expiry date';
                                    }
                                    if (!isValidExpiryDate(value)) {
                                      return 'Enter a valid expiry date';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {}); // تحديث عرض تاريخ الانتهاء
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: _cvvController,
                                  decoration: InputDecoration(
                                    labelText: 'CVV',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  obscureText: true,
                                  // maxLength: 3,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter CVV';
                                    }
                                    if (value.length != 3) {
                                      return 'CVV must be 3 digits';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {}); // تحديث عرض CVV
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // work space
                    Form(
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
                                } else if (!v.contains('@') ||
                                    !v.contains('.com')) {
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
                                      width: 3,
                                      color: AppColors.primary.withOpacity(.1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Colors.deepOrange.withOpacity(.4)),
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
                                      width: 3,
                                      color: AppColors.primary.withOpacity(.1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Colors.deepOrange.withOpacity(.4)),
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
                                      width: 3,
                                      color: AppColors.primary.withOpacity(.1)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Colors.deepOrange.withOpacity(.4)),
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
                          ],
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: h * 0.021),

            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ordernew();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 167, 98, 242),
              ),
              label: const Text(
                'Pay Now',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.credit_card,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }
}
