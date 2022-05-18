import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/ui/login/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void login(String email, String password)async{

    String? message=null;

    try {
      navigator?.showLoading(isDismissable: true);
      print('dialog shown');

      var result = await firebaseAuth.signInWithEmailAndPassword(email: email,
          password: password);
      // read user from Databse
      var userObj =await DataBaseUtils.readUser(result.user?.uid??"");
      if(userObj==null){
        message = 'faild to complete';
      }else{
        navigator?.goHome(userObj);
      }

    } on FirebaseAuthException catch (e) {
      message = 'Wrong Email or password';
    } catch (e) {
      message = 'something went wrong';
    }
    navigator?.hideLoading();
    if(message!=null){
      navigator?.showMessage(message);
    }
  }
}