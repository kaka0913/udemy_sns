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
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    // この変数を1回きり
    final User? onceUser = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: onceUser == null ?
      const LoginPage() : 
      const MyHomePage(title: appTitle),
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
    final MainModel mainModel = ref.watch(mainProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: mainModel.isLoading ?
      const Center(
        child: Text(loadingText),
      ) : 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("私の名前は${mainModel.currentUserDoc["uid"]}です"),
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