import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'UserModel.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  MyUser? _convertUser(User? user){
    return user!= null ?  MyUser(uid: user.uid,name:user.displayName==null?"anonuser":user.displayName):null;

  }
  Stream<MyUser?> get user{
    return _auth.authStateChanges()
    // .map((User user) => _convertUser(user));
        .map(_convertUser);

  }

  Future anonymousSignin() async {

    try {
      UserCredential Result=await _auth.signInAnonymously();
      User? anonuser=Result.user;
      return _convertUser(anonuser!);
    }
    catch(e){
      print(e.toString());
      return Null;

    }
  }
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

    final
    OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken
    );

    try {
      UserCredential Result=await _auth.signInWithCredential(credential);
      User? anonuser=Result.user;
      return _convertUser(anonuser!);
    }
    catch(e){
      print(e.toString());
      return Null;

    }


  }

  // Future Googlesignin()async{
  //   print("fail");
  //
  //   GoogleSignInAccount Googleuser= await GoogleSignIn().signIn();
  //
  //
  //   GoogleSignInAuthentication googleauth=await Googleuser.authentication;
  //   final GoogleAuthCredential credential=GoogleAuthProvider.credential(
  //     idToken: googleauth.idToken,
  //     accessToken: googleauth.accessToken,
  //   );
  //   UserCredential Result=await _auth.signInWithCredential(credential);
  //   User googleuser=Result.user;
  //   return _convertUser(googleuser);
  //
  // }
  Future signout() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());

    }

  }

}