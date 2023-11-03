// flutter
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udemy_flutter_sns/views/login_page.dart';
// model
import 'models/main_model.dart';
// options
import 'firebase_options.dart';
// constants
 import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
 // components
 import 'package:udemy_flutter_sns/details/rounded_button.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}
 
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // MyAppが起動した最初の時にユーザーがログインしているかどうかの確認
    // この変数を1回きり
    final MainModel mainModel = ref.watch(mainProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: mainModel.currentUser == null ?
      LoginPage(mainModel: mainModel,) : 
      MyHomePage(title: 'Flutter Demo Home Page',mainModel: mainModel,),
    );
  }
}
 
class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key, 
    required this.mainModel,
    required this.title
  }) : super(key: key);
  final String title;
  final MainModel mainModel;
 
  @override
  Widget build(BuildContext context) {
    
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
              color: Colors.blue,
              text: "サインアップページ"
            ),
            RoundedButton(
            onPressed: () => routes.toLoginPage(context: context, mainModel: mainModel),
            widthRate: 0.85, 
            color: Colors.green,
            text: "ログインページ"
          ),
            Text("Nullです")
          ],
      ),
      )
    );
  }
}