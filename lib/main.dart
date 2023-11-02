// flutter
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
// model
import 'main_model.dart';
// options
import 'firebase_options.dart';
 
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
 
class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
 
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    final TextEditingController emailEditingController = TextEditingController();
    final TextEditingController passwordEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailEditingController,
            onChanged: (text) => mainModel.email = text,
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: passwordEditingController,
            onChanged: (text) => mainModel.password = text,
          ),
          Center(
            child: mainModel.currentUser == null ?
            const Text("Nullです")
            : const Text("Nullじゃないです")
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mainModel.createUser(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}