import 'package:flutter/material.dart';

import '../constants/bottom_navigation_var_elements.dart';
import '../models/sns_buttom_navigation_var_model.dart';

class SNSBottomNavigationBar extends StatelessWidget {
  const SNSBottomNavigationBar({
    Key? key,
    required this.snsBottomNavigationBarModel
  }) : super(key: key);

  final SNSBottomNavigationBarModel snsBottomNavigationBarModel;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: bottomNavigationBarElements,
      currentIndex: snsBottomNavigationBarModel.currentIndex,
      onTap: (index) => snsBottomNavigationBarModel.onItemTapped(index: index)
      ,
    );
  }
}