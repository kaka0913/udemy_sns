import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snsBottomNavigationBarProvider = ChangeNotifierProvider((ref) => SNSBottomNavigationBarModel());

class SNSBottomNavigationBarModel extends ChangeNotifier {

  int currentIndex=0;
  late PageController pageController;

  SNSBottomNavigationBarModel(){
    init();
  }

  void init(){
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onItemTapped({required int index}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  void setPageController() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }
}
