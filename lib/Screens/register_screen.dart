import 'package:chatapp/Constants/constants.dart';
import 'package:chatapp/Screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/show_Snack_Bar.dart';
import '../Widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool? isLoading;

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
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  kLogo,
                  height: 100,
                ),
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
                const SizedBox(
                  height: 75,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'REGISTER',
                  onTap: () async {
                    if(formKey.currentState!.validate()){
                      isLoading = true;
                      setState(() {

                      });
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnakBar(context, 'weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnakBar(context, 'email already in use');
                        }
                      } catch (e) {
                        showSnakBar(context, 'There was an error');
                      }
                      isLoading = false;
                      setState(() {
                        
                      });
                    }else{}
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '  Login',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: password!);
  }
}
