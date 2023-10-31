// flutter
import 'package:flutter/material.dart';
// package
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user.dart';
 
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);
 
class MainModel extends ChangeNotifier {
 
  int counter = 0;
  Future<void> createUser({required BuildContext context}) async {
    final String v4 = const Uuid().v4();
    final FirestoreUser firestoreUser = FirestoreUser(uid: v4,userName: "Alice");
    final Map<String,dynamic> userData = firestoreUser.toJson();
    final Map<String,dynamic> userData2 = {
      "uid": "abcd",
      "userName": "Bob",
    };
    final FirestoreUser firestoreUser2 = FirestoreUser.fromJson(userData2);
    debugPrint(firestoreUser2.userName);
    await FirebaseFirestore.instance.collection("users").doc().set(userData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }
  
}