// flutter
import 'package:flutter/material.dart';
// package
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// domain
import 'package:udemy_flutter_sns/domain/firestore_user/firestore_user.dart';
 
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);
 
class MainModel extends ChangeNotifier {
 
  int counter = 0;
  Future<void> createUser({required BuildContext context}) async {
    final String v4 = const Uuid().v4();
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      uid: v4,
      updatedAt: now,
      userName: "Alice",
    );
    final Map<String,dynamic> userData = firestoreUser.toJson();
    await FirebaseFirestore.instance.collection("users").doc().set(userData);
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ユーザーが作成できました')));
    }   
    notifyListeners();
  }
  
}
