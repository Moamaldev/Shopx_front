import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/home_Screen.dart';
import 'package:shopx/state/fetch_Singel_user.dart';
import 'package:shopx/state/review_State.dart';

class CreateReview extends StatefulWidget {
  static const routename = '/add_review_screen';

  const CreateReview({super.key});

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  int rating = 0;
  String _subject = '';
  String _commint = '';
  String rate = '';
  final _formx = GlobalKey<FormState>();

  void reviewnow() async {
    final pid = ModalRoute.of(context)!.settings.arguments;
    final user = Provider.of<FetchSingelUser>(context, listen: false).user;
    var isvalid = _formx.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _formx.currentState?.save();
    bool isreviewed = await Provider.of<ReviewState>(context, listen: false)
        .reivewcreate(
            uid: user?.id as int,
            subject: _subject,
            commint: _commint,
            point: rating,
            productid: pid as String);

    if (isreviewed) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Great comment posted'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 114, 214, 213)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => HomeScreen()),
                        (route) => false);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Something is Wrong! Try Agane'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 93, 0, 0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new Review ',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formx,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter Your Subject';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (v) {
                    _subject = v!;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: AppColors.primary.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.deepOrange.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintStyle: const TextStyle(fontSize: 16),
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.subject_outlined,
                      color: Colors.deepOrange,
                    ),
                    hintText: "Subject",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter Your Comment';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (v) {
                    _commint = v!;
                  },
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: AppColors.primary.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Colors.deepOrange.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintStyle: const TextStyle(fontSize: 16),
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.comment_outlined,
                      color: Colors.deepOrange,
                    ),
                    hintText: "Comment",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //  padding: EdgeInsets.only(left: 5),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.deepOrange,
                          size: 30,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text('rating:  $rating'),
                        SizedBox(
                          width: 50,
                        ),
                        RatingBar.builder(
                            itemSize: 20,
                            updateOnDrag: true,
                            minRating: 0,
                            maxRating: 5,
                            itemBuilder: (ctx, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (r) => setState(() {
                                  this.rating = r.toInt();
                                })),
                      ]),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 104, 205, 165)),
                      onPressed: () {
                        reviewnow();
                        // ordernew();
                      },
                      child: const Text(
                        'Comment Now',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
