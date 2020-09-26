import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier
{
  bool isloading =false;
  changeisloading(bool val)
  {
    isloading =val;
    notifyListeners();
  }

}