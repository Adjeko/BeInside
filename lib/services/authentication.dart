import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

class Authentication {
  var auth = FirebaseAuth.instance;

  static void createUserWithEmail(String email, String password) async {
    final FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user;
  }

  static void signInWithEmail(String email, String password) async {
    final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: "adjekoooo@gmail.com", password: "hp1955")).user;
  }

  static void signOut() async {
    FirebaseAuth.instance.signOut();
  }

  static void googleSignIn() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    GoogleSignInAccount acc;
    try {
      acc = await googleSignIn.signIn();
    } catch (ex) {
      print("Hier passiert eine PlatformException wenn der User die Anmeldung abbricht. $ex");
    }
    
    final GoogleSignInAuthentication googleAuth = await acc.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken, 
      accessToken: googleAuth.accessToken);

    final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  }

  static void facebookSignIn() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        AuthCredential fbCredential = FacebookAuthProvider.getCredential(accessToken: token);
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(fbCredential)).user;
        return;
      case FacebookLoginStatus.cancelledByUser:
      case FacebookLoginStatus.error:
      default:

    }
  }

  static void twitterSignIn() async {
    String consumerKey = GetIt.I<RemoteConfig>().getString("twitterConsumerKey");
    String consumerSecret = GetIt.I<RemoteConfig>().getString("twitterConsumerSecret");

    final TwitterLogin twitterLogin = new TwitterLogin(consumerKey: consumerKey, consumerSecret: consumerSecret);

    //twitter has to be installed on the device for this line to work
    TwitterLoginResult twitterLoginResult = await twitterLogin.authorize();

    switch (twitterLoginResult.status) {
      case TwitterLoginStatus.loggedIn:
        TwitterSession currentUserSession = twitterLoginResult.session;

        AuthCredential twitterCredential = TwitterAuthProvider.getCredential(authToken: currentUserSession.token, authTokenSecret: currentUserSession.secret);
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(twitterCredential)).user;
        return;
      case TwitterLoginStatus.cancelledByUser:
        break;
      case TwitterLoginStatus.error:
        break;
    }
  }


}