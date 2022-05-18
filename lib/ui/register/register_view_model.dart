import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/firebase_error.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/register/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator>{


  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void register(String email, String password,String firstName, String lastName,String userName)async{

    String? message;

    try {
      navigator?.showLoading();
      var result = await firebaseAuth.createUserWithEmailAndPassword(email: email,
          password: password );

      var user = MyUser(id: result.user?.uid??"",
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);

   var task = await DataBaseUtils.createDBUser(user);
   navigator?.goHome(user);

    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weekPassword) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseError.emailInUse) {
        message = 'The account already exists for that email';
      }else {
        message = 'Wrong username or password';
      }
    } catch (e) {
      message = 'something went wrong';
    }
    navigator?.hideLoading();
    if(message!=null){
      navigator?.showMessage(message);
    }
  }
}
