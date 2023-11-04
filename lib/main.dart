// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udemy_flutter_sns/views/login_page.dart';
// model
import 'models/main_model.dart';
// options
import 'firebase_options.dart';
// constants
 import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
import 'package:udemy_flutter_sns/constants/strings.dart';
 // components
 import 'package:udemy_flutter_sns/details/rounded_button.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    //MyAppが起動した時にユーザがログインしているかどうかを確認する
    //この変数は１度しかつかわないので、finalをつけている
    final User? oneceUser = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: oneceUser == null ?
      LoginPage() : 
      MyHomePage(title: appTitle),
    );
  }
}
 
class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key, 
    required this.title
  }) : super(key: key);
  final String title;
 
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    //Mainmodelが起動されinitが実行される
    final MainModel mainModel = ref.watch(mainProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RoundedButton(
              onPressed: () => routes.toSignupPage(context: context),
              widthRate: 0.85,
              color: const Color.fromRGBO(33, 150, 243, 1),
              text: signupText
            ),
            RoundedButton(
              onPressed: () => routes.toLoginPage(context: context),
              widthRate: 0.85, 
              color: Colors.green,
              text: loginText
            ),
            Center(
              child: Text(mainModel.currentUserDoc["name"]),
            ),
            RoundedButton(
              onPressed: () async => await mainModel.logout(context: context, mainModel: mainModel),
              widthRate: 0.85, 
              color: Colors.red,
              text: logoutText
            ),
          ],
      ),
      )
    );
  }
}