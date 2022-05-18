import 'package:chat/base.dart';
import 'package:chat/model/my_user.dart';

abstract class LoginNavigator implements BaseNavigator{
 void goHome(MyUser user);
}