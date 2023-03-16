import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gig_soft_pro/auth/login_screen.dart';
import 'package:gig_soft_pro/home.dart';
import 'package:gig_soft_pro/model/auth_detail.dart';
import 'package:hive/hive.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email, userName, password;
  bool clicked = true;
  bool isloading = false;
  final formkey = GlobalKey<FormState>();
  bool isMatch = false;
  bool isRegisterUserNot = false;
  List<Data>? _auth = [];
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var box = await Hive.openBox('authDetail');

      var dataIS = await box.get('usersData');
      if (dataIS != null) {
        UserAuthModel? userModel;
        print("data is ==>$dataIS");
        ;
        userModel = UserAuthModel.fromJson(json.decode(dataIS.toString()));
        _auth = userModel.data;
        setState(() {});

        print('data is ===>>${userModel.data?.length}');
      }
    });
  }

  register() async {
   if(formkey.currentState!.validate()){ var box = await Hive.openBox('authDetail');

   for (int i = 0; i < (_auth?.length ?? 0); i++) {


     if (_auth?[i].name.toString() == emailController.text.toString().trim() &&
         _auth?[i].pass.toString() ==
             passwordController.text.toString().trim()) {
       isMatch = true;
       isRegisterUserNot = true;
       setState(() {});

     }
   }
   ;
   if (isRegisterUserNot == true) {

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User already Registered')));

   }
   if (isMatch == false) {

     _auth?.add(Data(
       name: emailController.text.trim(),
       pass: passwordController.text.trim(),
     ));
     setState(() {});


     var data = (_auth ?? []).map((v) => v.toJson()).toList();

     await box.put('usersData', json.encode(data));
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (_) => HomeScreen()));
   }

   setState(() {});}
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            color: Colors.indigo[100],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/bg.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          height: 200,
                          width: 88,
                          left: 15,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/light-1.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 150,
                          width: 88,
                          left: 115,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/light-1.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 160,
                          width: 88,
                          right: 50,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/clock.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Color.fromRGBO(143, 148, 251, 1),
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: userNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        userName = value;
                                      });
                                    },
                                    validator: (value) =>
                                        value!.length < 2 || value.isEmpty
                                            ? "enter a  unique userName"
                                            : null,
                                    decoration: const InputDecoration(
                                      hintText: "userName",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: emailController,
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    validator: (value) =>
                                        value!.length < 2 || value.isEmpty
                                            ? "enter a  valid email"
                                            : null,
                                    decoration: const InputDecoration(
                                      hintText: "email",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: clicked,
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    validator: (value) =>
                                        value!.length < 2 || value.isEmpty
                                            ? "enter a   6+ chars password"
                                            : null,
                                    decoration: InputDecoration(
                                      suffixIcon: clicked
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  clicked = false;
                                                  print(clicked);
                                                });
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.eyeSlash,
                                                color: Colors.indigo[400],
                                              ))
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  clicked = true;
                                                });
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.eye,
                                                color: Colors.indigo[400],
                                              )),
                                      hintText: "Password",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: register,
                          child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, 5),
                                ]),
                              ),
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                        // const SizedBox(
                        //   height: 20.0,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       alignment: Alignment.center,
                        //       height: 50,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         image: const DecorationImage(
                        //           image: AssetImage('assets/fb.png'),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 30.0),
                        //     Container(
                        //       alignment: Alignment.center,
                        //       height: 50,
                        //       width: 50,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(30.0),
                        //         image: const DecorationImage(
                        //           image: AssetImage('assets/gg.png'),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                              text: "Don\'t have an account ?",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.indigo[400],
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      }),
                              ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
  }
}
