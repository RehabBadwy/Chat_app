import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/add_room/add_room_screen.dart';
import 'package:chat/ui/chat/chat_screen.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider(),)
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        RegisterScreen.routeName: (context)=> RegisterScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        HomeScreen.routName:(context)=>HomeScreen(),
        AddRoomScreen.routeName:(context)=>AddRoomScreen(),
        ChatScreen.routeName:(context)=>ChatScreen(),
      },
      initialRoute: userProvider.firebaseUser==null? LoginScreen.routeName:
      HomeScreen.routName,
    );
  }
}

