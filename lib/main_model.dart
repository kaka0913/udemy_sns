// flutter
import 'package:flutter/material.dart';
// package
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);
 
class MainModel extends ChangeNotifier {
 
  int counter = 0;
  Future<void> createUser({required BuildContext context}) async {
    final String v4 = const Uuid().v4();
    final Map<String,dynamic> userData = {
      "userName": "Alice",
      "uid": v4,
    };
    await FirebaseFirestore.instance.collection("users").doc().set(userData);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }
  
}