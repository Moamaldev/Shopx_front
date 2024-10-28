import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/Review/create_review.dart';
import 'package:shopx/screens/Review/review_body.dart';
import 'package:shopx/state/fetch_Singel_user.dart';
import 'package:shopx/state/review_State.dart';
import 'package:shopx/style.dart';

class ReviewScreen extends StatefulWidget {
  static const routename = '/review_screen';

  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _innit = true;
  bool _isLoding = false;
  @override
  void didChangeDependencies() async {
    if (_innit) {
      _isLoding = await Provider.of<ReviewState>(context, listen: false)
          .fetchReviweData();
      setState(() {});
    }
    _innit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    final id = ModalRoute.of(context)!.settings.arguments;
    final revew = Provider.of<ReviewState>(context, listen: false)
        .reviewes
        .where((element) => element.product == id)
        .toList();
    if (!_isLoding) {
      return Scaffold(
          floatingActionButton: Padding(
            padding: standardPaddingX,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CreateReview.routename, arguments: id);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15)),
              child: PrimaryText(
                  text: "Add Review", color: AppColors.white, size: 18),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Please wait ..."),
          ),
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          floatingActionButton: Padding(
            padding: standardPaddingX,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CreateReview.routename, arguments: id);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15)),
              child: PrimaryText(
                  text: "Add Review", color: AppColors.white, size: 18),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Revewes"),
            backgroundColor: Colors.transparent,
          ),
          body: revew.isEmpty
              ? Center(
                  child: PrimaryText(
                    text: 'No Review yet! try add some Review ',
                    color: AppColors.primary,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: h * 0.75,
                      child: ListView.builder(
                        itemCount: revew.length,
                        itemBuilder: (context, index) {
                          final userId = revew[index].user;
                          final fetchUserProvider =
                              Provider.of<FetchSingelUser>(context,
                                  listen: false);

                          return FutureBuilder(
                            future: fetchUserProvider.fetchUserById('$userId'),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                // إذا اكتمل تحميل البيانات
                                final user = fetchUserProvider.getUserById(
                                    '$userId'); // جلب المستخدم حسب الـ id
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: ReviewBody(
                                            index: index,
                                            ratenum:
                                                revew[index].reviewPoint as int,
                                            uname: '${user?.username}',
                                            subject: '${revew[index].subject}',
                                            comment: '${revew[index].commint}',
                                          ),
                                        )
                                      ],

                                      //  Text('${revew[index].commint}'),
                                      //   Text('${revew[index].reviewPoint}'),
                                      //   Text('${revew[index].product}'),
                                      //   Text('${user?.username}'),
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ));
    }
  }
}
