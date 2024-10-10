import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/state/fetch_Singel_user.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    // استدعاء الدالة لجلب البيانات عند تحميل الشاشة
    Provider.of<FetchSingelUser>(context, listen: false).fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Consumer<FetchSingelUser>(
        builder: (context, userProvider, child) {
          if (userProvider.user == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${userProvider.user!.id}'),
                  Text('Username: ${userProvider.user!.username}'),
                  Text('First Name: ${userProvider.user!.firstName}'),
                  Text('Last Name: ${userProvider.user!.lastName}'),
                  Text('Email: ${userProvider.user!.email}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
