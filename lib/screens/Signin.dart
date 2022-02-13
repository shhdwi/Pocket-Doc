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
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              ElevatedButton(
                child: Text("Log In using Google"),
                onPressed: () async {
                  dynamic result=await _authService.signInWithGoogle();
                  if(result==null){
                    print("error");
                  }
                  else {
                    print("pappu pass");
                    print(result.uid);
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => UserHomePage(),
                      ),
                    );

                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
