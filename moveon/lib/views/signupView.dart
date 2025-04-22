





import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'loginview.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  TextEditingController semail_control = TextEditingController();
  TextEditingController spass_control = TextEditingController();
  TextEditingController name = TextEditingController();
   SnackBar signUp = SnackBar(
    content: Text('SingUp Seccesfully!'),
    backgroundColor: Color(0xFF756EF3),
  );
   SnackBar weakPassword = SnackBar(
    content: Text('Password is too weak'),
    backgroundColor: Color(0xFF756EF3),
  );
   SnackBar emailExist = SnackBar(
    content: Text('Email Already Exist'),
    backgroundColor: Color(0xFF756EF3),
  );

  void clearText() {
    semail_control.clear();
    spass_control.clear();
    name.clear();
  }

  signup(context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: semail_control.text,
        password: spass_control.text,
      );
       ScaffoldMessenger.of(context).showSnackBar(signUp);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
         ScaffoldMessenger.of(context).showSnackBar(weakPassword);
      } else if (e.code == 'email-already-in-use') {
         ScaffoldMessenger.of(context).showSnackBar(emailExist);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginView(),
                      ),
                    );
                  },
                  child: Image.asset("assets/images/Back.png")),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
              ),
              Text(
                "Sign Up",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF002055),
                    height: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text("Create Account",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF002055),
                      height: 1.2,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Text("Please enter your information and",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color : Color(0xFF868D95),
                        height: 1),
                  )),
              const SizedBox(
                height: 10,
              ),
              Text("Create your account",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                       color : Color(0xFF868D95),
                        height: 1),
                  )),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(hintText: "Enter Your Name", controller: name)
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child:MyTextField(hintText: "Enter Your Mail",controller: semail_control,)
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(hintText: "Enter Your Password",controller: spass_control,)
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: GradientButton(
                  onPressed: () {
                    signup(context);
                    clearText();
                  },
                  gradientColors: const [Color(0xFF756EF3), Color(0xFF756EF3)],
                  width: MediaQuery.of(context).size.width * 0.9, // Set the width
                  height: 47.0,
                  child: Text(
                    'Sign Up',
                   style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                             color :Color(0xFFFFFFFF),
                              height: 1),
                        
                  ),), // Set the height
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Signin with",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                             color : Color(0xFF868D95),
                              height: 1),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Google.png"),
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset("assets/images/Apple.png")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Have an Account?",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color:Color(0xFF868D95),
                                height: 2,
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          },
                          child: Text("Sign In",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF756EF3),
                                 
                                ),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
