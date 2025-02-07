import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/homescreen.dart';

class SignUp extends StatelessWidget {
   SignUp({super.key});

  TextEditingController gmail = TextEditingController();
  TextEditingController passWord= TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  Future signinuser(context) async {
    final password = passWord.text;
    final confirmpassword = confirmPass.text;
    if (password == confirmpassword) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: gmail.text.trim(),
          password: passWord.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Color.fromARGB(255, 2, 192, 72),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10.0),
            content: Text('Account Successfully Created ')));
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      } on FirebaseAuthException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Color.fromARGB(255, 238, 103, 94),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10.0),
            content: Text('Try Again ')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 238, 103, 94),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10.0),
          content: Text('Password Doesnot Match')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Welcome..",
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
                      controller: gmail,
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
                      controller: passWord,
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
                    TextField(
                      controller: confirmPass,
                      decoration: InputDecoration(
                          labelText: "ConfirmPassword",
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
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signinuser(context);
                      },
                      child: Text("SignUp"),
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
