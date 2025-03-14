import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:room_app/auth/google_auth.dart';
import 'package:room_app/auth/socialAuth.dart';
import 'package:room_app/screens/main_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Login or Sign up",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(color: Colors.black12),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to Star Rooms"),

                    PhoneNumberField(size),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text:
                            "well call or text you to confirm you number. Standart message and date rates apply.",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink,
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.026),
                    Row(
                      children: [
                        Expanded(
                          child: Container(height: 1, color: Colors.black26),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Or", style: TextStyle(fontSize: 18)),
                        ),
                        Expanded(
                          child: Container(height: 1, color: Colors.black26),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    SocialIcons(
                      size: size,
                      name: "Continue with Facebook",

                      icon: Icons.facebook,

                      color: Colors.blue,
                      iconSize: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuthService().signInWithGoogle();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen()),
                        );
                      },
                      child: SocialIcons(
                        size: size,
                        name: "Continue with Google",

                        icon: FontAwesomeIcons.google,

                        color: Colors.pink,
                        iconSize: 27,
                      ),
                    ),
                    SocialIcons(
                      size: size,
                      name: "Continue with Apple",

                      icon: Icons.apple,

                      color: Colors.black,
                      iconSize: 30,
                    ),
                    SocialIcons(
                      size: size,
                      name: "Continue with email",

                      icon: Icons.email_outlined,

                      color: Colors.black,
                      iconSize: 30,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Need help?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Padding SocialIcons(Size size,icon,name,color,double iconSize) {
  //   return Padding(padding: EdgeInsets.only(bottom: 15),
  //               child: Container(
  //                 width: size.width,
  //                 padding: EdgeInsets.symmetric(vertical: 11),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all()
  //                 ),
  //                 child: Row(children: [
  //                   SizedBox(width: size.width * 0.05,),
  //                   Icon(icon,
  //                   color: color,
  //                   size: iconSize,
  //                   ),
  //                   SizedBox(width: size.width * 0.18,),
  //                   Text(
  //                     name,
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w500
  //                     )
  //                   ),
  //                   SizedBox(width: 10,)
  //                 ],),
  //               ),);
  // }

  // //phone number field
  Container PhoneNumberField(Size size) {
    return Container(
      width: size.width,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10, top: 8),
            child: Column(
              children: [
                Text("Country/Regin", style: TextStyle(color: Colors.black45)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Egypt(+20)',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp, size: 30),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Phone number",
                hintStyle: TextStyle(fontSize: 18, color: Colors.black45),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
