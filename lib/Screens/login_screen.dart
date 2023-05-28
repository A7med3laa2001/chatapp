import 'package:chatapp/Screens/chat_screen.dart';
import 'package:chatapp/Screens/register_screen.dart';
import 'package:chatapp/Widgets/custom_button.dart';
import 'package:chatapp/Widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Constants/constants.dart';
import '../Widgets/show_Snack_Bar.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static String id = 'LoginPage';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool? isLoading;
  String? email;

  String? password;


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading = false,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 75,),
                Image.asset(kLogo,height: 100,),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 75,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (data){
                    email = data;
                  },
                ),
                const SizedBox(height: 10,),
                CustomTextFormField(
                  obscureText:true,
                  hintText: 'Password',
                  onChanged: (data){
                    password = data;
                  },
                ),
                const SizedBox(height: 20,),
                 CustomButton(
                   text: 'LOGIN',
                     onTap: () async {
                       if(formKey.currentState!.validate()){
                         isLoading = true;
                         setState(() {

                         });
                         try {
                           await loginUser();
                           Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                         } on FirebaseAuthException catch (e) {
                           if (e.code == 'user-not-found') {
                             showSnakBar(context, 'user not found');
                           } else if (e.code == 'wrong-password') {
                             showSnakBar(context, 'wrong password');
                           }
                         } catch (e) {
                           showSnakBar(context, 'There was an error');
                         }
                         isLoading = false;
                         setState(() {

                         });
                       }else{}
                     }
                 ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('don\'t have any account?',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    GestureDetector(onTap: (){
                      Navigator.pushNamed(context, RegisterScreen.id);
                    }, child: const Text('  Register',style: TextStyle(color: Color(0xffC7EDE6)),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
