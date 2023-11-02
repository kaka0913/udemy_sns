// flutter
import 'package:flutter/material.dart';
// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final mainProvider = ChangeNotifierProvider(
  (ref) => MainModel()
);
 
class MainModel extends ChangeNotifier {
  
}