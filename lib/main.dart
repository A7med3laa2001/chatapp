import 'package:chatapp/Screens/chat_screen.dart';
import 'package:chatapp/Screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'Screens/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id:(context) => LoginScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        ChatScreen.id : (context) => ChatScreen(),
      },
      initialRoute: 'LoginPage',
    );
  }
}
