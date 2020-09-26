import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier
{
  bool isadmin=false;
  changeisAdmin(bool val)
  {
    isadmin=val;
    notifyListeners();

  }
}