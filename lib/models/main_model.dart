// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);
 
class MainModel extends ChangeNotifier {
  User? currentUser;
  late DocumentSnapshot<Map<String,dynamic>> currentUserDoc ;

  MainModel() {
    init();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> init() async {
    //modelを跨がないでcurrentuserの更新を行う
    currentUser = FirebaseAuth.instance.currentUser;
    //
    await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).get().then((value) => currentUserDoc = value);
    notifyListeners();
  }
 
  Future<void> logout({required BuildContext context,required MainModel mainModel}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    if(context.mounted){
          routes.toLoginPage(context: context);
    }
  }
}