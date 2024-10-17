import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/models/order.dart';
import 'package:shopx/state/product_State.dart';
import 'package:shopx/style.dart';

class OrderHistoryBody extends StatelessWidget {
  final List<order>? oldorder;

  const OrderHistoryBody({super.key, required this.oldorder});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    if (oldorder!.isEmpty) {
      return Center(child: PrimaryText(text: 'No Orders! Please Make New'));
    } else {
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView.builder(
          itemCount: oldorder?.length,
          itemBuilder: (context, index) => Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address :  ${oldorder?[index].address}',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Phone :   ${oldorder?[index].phone}',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Email :  ${oldorder?[index].email}',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  'Total :  \$ ${oldorder?[index].total}',
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'paymentMethod : ${oldorder![index].paymentMethod}',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    oldorder![index].paymentMethod == 'Cash'
                        ? Icon(
                            Icons.money,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.credit_card,
                            color: AppColors.primary,
                          )
                  ],
                ),
                Text(
                  'Status :  ${oldorder![index].status}',
                  style: TextStyle(
                      color: oldorder![index].status == 'PROCESSING'
                          ? AppColors.primary
                          : oldorder![index].status == 'SHIPPED'
                              ? Colors.teal
                              : oldorder![index].status == 'COMPLETED'
                                  ? Colors.green
                                  : const Color.fromARGB(255, 93, 9, 3),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Order Details  ',
                  style: TextStyle(color: AppColors.primary, fontSize: 16),
                ),
                Divider(
                  color: AppColors.black,
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: h * 0.16,
                    child: ListView.builder(
                      itemCount: oldorder?[index].productsList?.length,
                      itemBuilder: (context, i) {
                        var products = oldorder?[index].productsList?[i];
                        final product = Provider.of<ProductState>(context)
                            .singelProduct(products?['productId']);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.045,
                            ),
                            Container(
                              width: w * 0.19,
                              height: h * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'http://10.0.2.2:8000${product.img}'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: w * 0.045,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${product.titel}',
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 16),
                                ),
                                Text(
                                  'Quantity:(${products?['quantity']})',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 140, 11, 2),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.13,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      );
    }
  }
}
