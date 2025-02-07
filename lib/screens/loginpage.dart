import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/homescreen.dart';
import 'package:task/screens/signUp.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController resetEmail = TextEditingController();

  Future<void> signInUser(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      print("-------------$e");
      final errorMessage = 'Email and Password do not match';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 238, 103, 94),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10.0),
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future resetpassword(context) async {
    final emaill = resetEmail.text;
    if (emaill.contains('@')) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emaill);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 6, 157, 21),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10.0),
          content: Text('Reset Email has been send to $emaill')));
      Navigator.of(context).pushNamed('login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 238, 103, 94),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10.0),
          content: Text('Enter correct Email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb5d0a6),
      body: Stack(children: [
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
            "Welcome Back",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(30),
            height: MediaQuery.of(context).size.height / 1.3,
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
                  height: 90,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid)),
                      labelText: "Gmail",
                      labelStyle: TextStyle(color: Color(0xff1c4c36)),
                      enabled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid))),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Color(0xff1c4c36)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid))),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        "forgotpassword?",
                        style: TextStyle(color: Color(0xff1c4c36)),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Color(0xff1c4c36)),
                              ),
                              content: TextFormField(
                                controller: resetEmail,
                                decoration: InputDecoration(
                                    labelText: "Enter your user name"),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    resetpassword(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("sis");
                      signInUser(context);
                    },
                    child: Text(
                      "SignIn",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1c4c36),
                        shape: BeveledRectangleBorder(),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width, 60))),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Dont have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(color: Color(0xff1c4c36)),
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
