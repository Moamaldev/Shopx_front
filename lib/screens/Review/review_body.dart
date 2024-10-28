import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopx/colors.dart';

class ReviewBody extends StatefulWidget {
  final int index, ratenum;
  final String uname, subject, comment;

  const ReviewBody(
      {super.key,
      required this.index,
      required this.ratenum,
      required this.uname,
      required this.subject,
      required this.comment});

  @override
  State<ReviewBody> createState() => _ReviewBodyState();
}

class _ReviewBodyState extends State<ReviewBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(12),
        height: 110,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 20,
              child: Text(
                '${widget.index + 1}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('from : ${widget.uname}'),
                Text('subject : ${widget.subject}'),
                Text('commint : ${widget.comment}'),
                Row(
                  children: [
                    Text('reviewPoint :'),
                    RatingBarIndicator(
                      rating: widget.ratenum.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
