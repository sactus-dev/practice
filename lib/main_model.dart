
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{

  String mainTitle = 'main title';


  void changeText(){
    mainTitle = 'メインタイトル';
    notifyListeners();
  }

}