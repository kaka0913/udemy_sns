// flutter
import 'package:flutter/material.dart';
// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:udemy_flutter_sns/constants/routes.dart' as routes;
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);
 
class MainModel extends ChangeNotifier {
  User? currentUser;
  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
 
  Future<void> logout({required BuildContext context,required MainModel mainModel}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    routes.toLoginPage(context: context, mainModel: mainModel);
  }
}