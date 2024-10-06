import 'package:flutter/material.dart';
import 'package:shopx/animation/fade_Animaton.dart';
import 'package:shopx/colors.dart';
import 'package:shopx/screens/auth/login_Screen.dart';
import 'package:shopx/style.dart';

class RigesterScreen extends StatefulWidget {
  static const routename = '/rigester_screen';

  const RigesterScreen({super.key});

  @override
  State<RigesterScreen> createState() => _RigesterScreenState();
}

class _RigesterScreenState extends State<RigesterScreen> {
  bool _isObscured = true;
  String _username = '';
  String _password = '';
  String _confpassword = '';

  String _first_name = '';
  String _last_name = '';
  String _email = '';

  final _form = GlobalKey<FormState>();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();

  void _loginNew() {
    var isvalid = _form.currentState?.validate();
    if (!isvalid!) {
      return;
    }
    _form.currentState!.save();

    print(
        'username = $_username ,password = $_password  , email = $_email , first_name = $_first_name , last_name = $_last_name , cof= $_confpassword');
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
              text: 'Rigester',
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
                const SizedBox(height: 5),
                FadeAnimation(
                  1.2,
                  Center(
                    child: PrimaryText(
                      text: 'Wellcom To Shopx',
                      color: AppColors.black,
                    ),
                  ),
                ),
//FnameS
                const SizedBox(height: 10),
                FadeAnimation(
                  1,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your First Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
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
                        _first_name = v!;
                      });
                    },
                  ),
                ),
//Lname
                const SizedBox(height: 30),
                FadeAnimation(
                  0.9,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Last Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
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
                        _last_name = v!;
                      });
                    },
                  ),
                ),

//Email
                const SizedBox(height: 30),
                FadeAnimation(
                  0.8,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Email';
                      } else if (!value.contains('@') ||
                          !value.contains('.com')) {
                        return 'Use a correct Email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                        _email = v!;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 30),
//uname
                FadeAnimation(
                  0.7,
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

//pass
                const SizedBox(height: 30),
                FadeAnimation(
                  0.6,
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Password';
                      } else if (value.length < 8) {
                        return ' Your Password is not Strong ';
                      } else {
                        return null;
                      }
                    },
                    autocorrect: false,
                    enableSuggestions: false,
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
                    onChanged: (val) {
                      setState(() {
                        _confpassword = val;
                      });
                    },
                    onSaved: (v) {
                      _password = v!;
                    },
                  ),
                ),
//Conf pass
                const SizedBox(height: 30),
                FadeAnimation(
                  0.6,
                  TextFormField(
                    validator: (value) {
                      if (_confpassword != value) {
                        return 'Not Match your Password';
                      } else if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    obscureText: _isObscured, // حالة الرؤية
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: 'Confirm your password',
                      hintText: "Rewrite your Password",
                      prefixIcon: Icon(Icons.lock),
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
//btn
                const SizedBox(height: 30),
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
                          'Register Now',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
                        ),
                      ),
                      const Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 22, 34),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routename);
                        },
                        child: const Text(
                          'Login',
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
