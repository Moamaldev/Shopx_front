import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/state/cart_Getx.dart';
import 'package:shopx/state/fetch_Singel_user.dart';

class PaymentWithcard extends StatefulWidget {
  final String total;
  final List<String> item;
  const PaymentWithcard({super.key, required this.total, required this.item});

  @override
  State<PaymentWithcard> createState() => _PaymentWithcardState();
}

final Cartx cartx = Get.find();

class _PaymentWithcardState extends State<PaymentWithcard> {
  final Map<String, String> customCaptions = {
    'PREV': 'Prev',
    'NEXT': 'Next',
    'DONE': 'Done',
    'CARD_NUMBER': 'Card Number',
    'CARDHOLDER_NAME': 'Cardholder Name',
    'VALID_THRU': 'Valid Thru',
    'SECURITY_CODE_CVC': 'Security Code (CVC)',
    'NAME_SURNAME': 'Name',
    'MM_YY': 'MM/YY',
    'RESET': 'Reset',
  };
  final buttonStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(30.0),
    gradient: LinearGradient(
        colors: [Color(0xFFA95EFA), Color(0xFFA95EFA).withOpacity(.5)],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp),
  );

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

  String _email = '';
  String _phone = '';
  String _address = '';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final _form = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); //card

  void ordernew() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState?.save();

    print(_email);
    print(_phone);
    print(_address);

    final uid = Provider.of<FetchSingelUser>(context, listen: false).user?.id;
    print(uid);

    // bool order = await Provider.of<OrderState>(context, listen: false).orderNow(
    //     address: _address,
    //     email: _email,
    //     phone: _phone,
    //     products_list: widget.item,
    //     uid: uid,
    //     total: widget.total,
    //     payment_method: 'Card');

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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: h * 0.28,
              decoration: cardDecoration,
              child: CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Axis Bank',
                frontCardBorder:
                    useGlassMorphism ? null : Border.all(color: Colors.grey),
                backCardBorder:
                    useGlassMorphism ? null : Border.all(color: Colors.grey),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                backgroundImage:
                    !useBackgroundImage ? 'assets/card_bg.png' : null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: cardNumber.startsWith('4')
                        ? CardType.visa
                        : CardType.mastercard,
                    cardImage: cardNumber.startsWith('4')
                        ? Image.asset(
                            'assets/visacard.png',
                            height: 48,
                            width: 48,
                          )
                        : Image.asset(
                            'assets/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: h * 0.49,
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        inputConfiguration: const InputConfiguration(
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration: InputDecoration(
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelText: 'Card Holder',
                          ),
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
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
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            // another page
            ElevatedButton.icon(
              onPressed: () {
                ordernew();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 167, 98, 242),
              ),
              label: const Text(
                'Order with Credit Card',
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

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
