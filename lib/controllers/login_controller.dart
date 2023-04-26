import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  login() async{

      _googleSignin.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        print("user changed"); // never gets called
      });
      googleAccount.value = await _googleSignin.signIn();
      await _googleSignin.signInSilently();
      await _googleSignin.requestScopes(_googleSignin.scopes);

  }
}