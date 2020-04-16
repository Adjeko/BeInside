import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  var auth = FirebaseAuth.instance;



  static void createUserWithEmail(String email, String password) async {
    final FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user;
  }

  static void signInWithEmail(String email, String password) async {
    final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjekoooo@gmail.com", password: "hp1955")).user;
  }

  static void googleSignIn() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    final GoogleSignInAccount acc = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await acc.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken, 
      accessToken: googleAuth.accessToken);

    final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  }
}