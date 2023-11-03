// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// model
import 'package:udemy_flutter_sns/models/login_model.dart';
 
class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
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
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailEditingController,
            onChanged: (text) => loginModel.email = text,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordEditingController,
            onChanged: (text) => loginModel.password = text,
            obscureText: loginModel.isObscure,
            decoration: InputDecoration(
              suffix: 
              InkWell(
                child: loginModel.isObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                onTap: () => loginModel.toggleIsObscure(),
              )
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => loginModel.login(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}