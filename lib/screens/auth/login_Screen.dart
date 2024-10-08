import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopx/animation/fade_Animaton.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/auth/rigester_Screen.dart';
import 'package:shopx/state/user_State.dart';
import 'package:shopx/style.dart';
import 'package:shopx/widgets/bottomBar.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  String _username = '';
  String _password = '';
  final _form = GlobalKey<FormState>();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();

  void _loginNew() async {
    var isvalid = _form.currentState?.validate();
    if (!isvalid!) {
      return;
    }
    _form.currentState!.save();
    bool istoken = await Provider.of<UserState>(context, listen: false)
        .loginNow(_username, _password);
    if (istoken) {
      Navigator.of(context).pushReplacementNamed(BottomBar.routename);
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
                PrimaryText(
                  text: 'Check UserName , PassWord',
                  size: 14,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: FadeAnimation(
          2,
          Center(
            child: PrimaryText(
              text: 'Login',
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                // const SizedBox(height: 40),
                const SizedBox(height: 20),
                FadeAnimation(
                  1.2,
                  Center(
                    child: PrimaryText(
                      text: 'Wellcom Back',
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeAnimation(
                  0.8,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.people),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0), // لون الحدود عند عدم التركيز
                        borderRadius:
                            BorderRadius.circular(15.0), // زوايا مستديرة
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2.0), // لون الحدود عند التركيز
                        borderRadius:
                            BorderRadius.circular(20.0), // زوايا مستديرة
                      ),
                    ),
                    onSaved: (v) {
                      setState(() {
                        _username = v!;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 40),
                FadeAnimation(
                  0.6,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: _isObscured, // حالة الرؤية
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility : Icons.visibility_off,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured; // تغيير حالة الرؤية
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0), // لون الحدود عند عدم التركيز
                        borderRadius:
                            BorderRadius.circular(15.0), // زوايا مستديرة
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2.0), // لون الحدود عند التركيز
                        borderRadius:
                            BorderRadius.circular(20.0), // زوايا مستديرة
                      ),
                    ),
                    onSaved: (v) {
                      _password = v!;
                    },
                  ),
                ),

                const SizedBox(height: 40),
                FadeAnimation(
                  0.4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {
                          _loginNew();
                        },
                        child: const Text(
                          'Login Now',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 22, 34),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RigesterScreen.routename);
                        },
                        child: const Text(
                          'Register New',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
