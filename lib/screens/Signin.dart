import 'package:flutter/material.dart';
import 'package:pocket_doc/screens/user_homepage.dart';

import '../services/auth.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  _SigninpageState createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  @override
  final AuthService _authService=AuthService();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1,),
              Image(image:AssetImage("assets/images/pocdoc.jpg")),
              Spacer(),
              // InkWell(
              //
              //   onTap: () async {
              //   dynamic result=await _authService.signInWithGoogle();
              //   if(result==null){
              //   print("error");
              //   }
              //   else {
              //   print("pappu pass");
              //   print(result.uid);
              //   Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //   builder: (BuildContext context) => UserHomePage(),
              //   ),
              //   );
              //
              //   }},
              //
              //   child: Container(
              //     height: 150,
              //
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //
              //       children: [
              //         Container(
              //             child:Image(fit: BoxFit.contain, image: AssetImage("assets/images/glogo.png")),
              //           height: 50,
              //         ),
              //         Text(" Sign in with Google",
              //         style: TextStyle(
              //           // height: 50,
              //           color: Colors.black38,
              //           fontSize: 20,
              //         ),),
              //
              //       ],
              //     )
              //   ),
              // ),

              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.white) ),
                child: Container(
                  width: 250,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        child:Image(fit: BoxFit.contain, image: AssetImage("assets/images/glogo.png")),
                        height: 30,
                      ),
                      Text("     Sign in with Google",
                        style: TextStyle(
                          // height: 50,
                          color: Colors.black54,
                          fontSize: 20,
                        ),),

                    ],
                  ),
                ),
                onPressed: () async {
                  dynamic result=await _authService.signInWithGoogle();
                  if(result==null){
                    print("error");
                  }
                  else {
                    print("pappu pass");
                    print(result.uid);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => UserHomePage(),
                      ),
                    );

                  }
                },
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
