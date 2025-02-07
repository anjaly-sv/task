import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<void> signIp(context) async {
    final mail = email.text.trim();
    final passWord = password.text.trim();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: passWord);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: passWord);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.deepOrange,
          behavior: SnackBarBehavior.floating,
          content: Text("Account Successfully Loged in")),
      );
      Navigator.pushNamed(context, "HomePage");
    } on FirebaseAuthException catch (e) {
      final errormsg = "Email or Password does not match";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.amber,
          behavior: SnackBarBehavior.floating,
          content: Text(errormsg)));
      print("the errorr-----------$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb5d0a6),
      body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xff1c4c36), Colors.black])),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Welcome Back..",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(30),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          labelText: "Gmail",
                          enabled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid))),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid))),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("forgotpassword?"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIp(context);
                      },
                      child: Text("SignIn"),
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(),
                          minimumSize:
                          Size(MediaQuery
                              .of(context)
                              .size
                              .width, 50)),
                    )
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
