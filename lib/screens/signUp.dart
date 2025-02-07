import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/homescreen.dart';
import 'package:task/screens/loginpage.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController gmail = TextEditingController();
  TextEditingController passWord = TextEditingController();
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
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
            "Hello Welcome",
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
                  height: 80,
                ),
                TextField(
                  controller: gmail,
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
                  controller: passWord,
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
                  height: 12,
                ),
                TextField(
                  controller: confirmPass,
                  decoration: InputDecoration(
                      labelText: "ConfirmPassword",
                      labelStyle: TextStyle(color: Color(0xff1c4c36)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black, style: BorderStyle.solid))),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    signinuser(context);
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1c4c36),
                    // side: BorderSide(color: Color(0xff1c4c36)),
                    shape: BeveledRectangleBorder(),
                    fixedSize: Size(MediaQuery.of(context).size.width, 60),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        child: Text(
                          "Login",
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
