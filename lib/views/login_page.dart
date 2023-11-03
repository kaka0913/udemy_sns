// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:udemy_flutter_sns/details/rounded_text_field.dart';
import 'package:udemy_flutter_sns/details/rounded_password_field.dart';
import 'package:udemy_flutter_sns/details/rounded_button.dart';
// model
import 'package:udemy_flutter_sns/models/login_model.dart';
import 'package:udemy_flutter_sns/models/main_model.dart';
 
class LoginPage extends ConsumerWidget {
  const LoginPage({
    Key? key,
    required this.mainModel
  }) : super(key: key);
  final MainModel mainModel;
 
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);
    final TextEditingController emailEditingController = TextEditingController(text: loginModel.email);
    final TextEditingController passwordEditingController = TextEditingController(text: loginModel.password);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ログイン"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedTextField(
            controller: emailEditingController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => loginModel.email = text,
            borderColor: Colors.black,
            shadowColor: Colors.red.withOpacity(0.3),
            hintText: "メールアドレス",
          ),
          RoundedPasswordField(
            onChanged: (text) => loginModel.password = text,
            passwordEditingController: passwordEditingController, 
            obscureText: loginModel.isObscure, 
            toggleObscureText: () => loginModel.toggleIsObscure(),
            borderColor: Colors.black, 
            shadowColor: Colors.blue.withOpacity(0.3),
          ),
          RoundedButton(
            onPressed: () async => await loginModel.login(context: context,mainModel: mainModel),
            widthRate: 0.85, 
            color: Colors.green,
            text: "ログイン"
          ),
        ],
      ),
    );
  }
}