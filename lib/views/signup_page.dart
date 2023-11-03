// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';
// models
import 'package:udemy_flutter_sns/models/signup_model.dart';
 
class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);
    final TextEditingController emailEditingController = TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController = TextEditingController(text: signupModel.password);
    return Scaffold(
      appBar: AppBar(
        title: const Text("サインアップ"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
            controller: emailEditingController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => signupModel.email = text,
            borderColor: Colors.black,
            shadowColor: const Color(0xFF77BFA3).withOpacity(0.3),
            hintText: "メールアドレス"
          ),
          RoundedPasswordField(
            onChanged: (text) => signupModel.password = text,
            passwordEditingController: passwordEditingController, 
            obscureText: signupModel.isObscure, 
            toggleObscureText: () => signupModel.toggleIsObscure(), 
            borderColor: Colors.black, 
            shadowColor: const Color(0xFFEDEEC9)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signupModel.createUser(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}