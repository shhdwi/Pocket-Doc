import 'package:flutter/material.dart';
import 'package:pocket_doc/screens/Signin.dart';
import 'package:pocket_doc/screens/user_homepage.dart';
import 'package:provider/provider.dart';

import '../services/UserModel.dart';
import '../services/auth.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<MyUser?>(context);

    print(user);
    if(user!=null){
      return UserHomePage();
    }
    else{
      return Signinpage();}
  }
}
