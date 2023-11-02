// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailEditingController,
            onChanged: (text) => signupModel.email = text,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordEditingController,
            onChanged: (text) => signupModel.password = text,
            obscureText: signupModel.isObscure,
            decoration: InputDecoration(
              suffix: 
              InkWell(
                child: const Icon(Icons.visibility_off),
                onTap: () => signupModel.toggleIsObscure(),
              )
            ),
          ),
          Center(
            child: signupModel.currentUser == null ?
            const Text("Nullです")
            : const Text("Nullじゃないです")
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