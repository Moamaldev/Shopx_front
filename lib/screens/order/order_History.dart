import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopx/animation/fade_Animaton.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/config/size_config.dart';
import 'package:shopx/screens/order/order_history_body.dart';
import 'package:shopx/state/order_State.dart';
import 'package:shopx/widgets/customDrawer.dart';

class OrderHistory extends StatefulWidget {
  static const routename = '/order_history';

  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  bool _innit = true;
  bool _isLoding = false;
  @override
  void didChangeDependencies() async {
    if (_innit) {
      _isLoding =
          await Provider.of<OrderState>(context, listen: false).getoldOrders();
      setState(() {});
    }
    _innit = false;
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OrderState>(context, listen: false).oldorder;

    if (!_isLoding) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Please wait ..."),
          ),
          body: Center(child: CircularProgressIndicator()) // حالة التحميل
          );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false, // يوخر التحكم من الاب بار
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RawMaterialButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 11.0),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                  ),
                  fillColor: AppColors.white,
                  child: SvgPicture.asset(
                    "assets/menu.svg",
                    // ignore: deprecated_member_use
                    color: AppColors.black,
                    width: 20,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth / 5.9,
              ),
              const FadeAnimation(
                0.4,
                Text('Order History'),
              )
            ],
          ),
          elevation: 0,
        ),
        body: OrderHistoryBody(oldorder: data),
      );
    }
  }
}
