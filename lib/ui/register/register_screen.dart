
import 'package:chat/model/my_user.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/register/navigator.dart';
import 'package:chat/ui/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';

class RegisterScreen extends StatefulWidget {

  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen,RegisterViewModel>
    implements RegisterNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  String firstName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';

  @override
  void initState() {
    super.initState();

    viewModel.navigator = this;
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
               "Chat",
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
                       labelText: 'First Name'
                     ),
                     onChanged: (text){
                       firstName = text;
                     },
                     validator: (text){
                       if(text==null||text.trim().isEmpty){
                         return 'Please Write Name';
                       }
                       return null;
                     },
                   ),
                   TextFormField(
                     decoration: InputDecoration(
                         labelText: 'Last Name'
                     ),
                     onChanged: (text){
                       lastName = text;
                     },
                     validator: (text){
                       if(text==null||text.trim().isEmpty){
                         return 'Please Write Name';
                       }
                       return null;
                     },
                   ),
                   TextFormField(
                     decoration: InputDecoration(
                         labelText: 'User Name'
                     ),
                     onChanged: (text){
                       userName = text;
                     },
                     validator: (text){
                       if(text==null||text.trim().isEmpty){
                         return 'Please Write Name';
                       }
                       if(text.contains(' ')){
                         return 'Please dont space';
                       }
                       return null;
                     },
                   ),
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
                         'Create'
                       )),
                   InkWell(
                       onTap: (){
                         Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
      viewModel.register(email, password,firstName,lastName,userName);
    }
  }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  void goHome(MyUser user) {
    hideLoading();
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user;
    Navigator.of(context)
        .pushReplacementNamed(HomeScreen.routName);
  }

}
