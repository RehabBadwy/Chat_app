import 'package:chat/base.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_view_model.dart';
import 'package:chat/ui/login/navigator.dart';
import 'package:chat/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel>
    implements LoginNavigator {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email ='';
  String password = '';

  @override
  void initState() {
    // TODO: implement initState
    viewModel.navigator =this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset('assets/images/background_image.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "Login",
                textAlign: TextAlign.center,
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email'
                      ),
                      onChanged: (text){
                        email = text;
                      },
                      validator: (text){
                        if(text==null||text.trim().isEmpty){
                          return 'Please Write Name';
                        }
                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid){
                          return 'please not nalid';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password'
                      ),
                      onChanged: (text){
                        password = text;
                      },
                      validator: (text){
                        if(text==null||text.trim().isEmpty){
                          return 'Please Write Name';
                        }
                        if(text.trim().length<6){
                          return 'Pleas 6';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(onPressed: (){
                      validateForm();
                    },
                        child: Text(
                            'Login'
                        )),
                     InkWell(
                         onTap: (){
                           Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                         },
                         child: Text('Dont have an account'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void validateForm(){
    if(formKey.currentState?.validate()==true){
      viewModel.login(email, password);
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }
  @override
  void goHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user;
    Navigator.of(context)
        .pushReplacementNamed(HomeScreen.routName);
  }
}
