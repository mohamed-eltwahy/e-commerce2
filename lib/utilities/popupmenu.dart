
import 'package:flutter/material.dart';

class Mypopupmenuitem<T> extends PopupMenuItem<T>
{
  final Widget child;
  final Function onclick;
  Mypopupmenuitem({@required this.child,@required this.onclick}):
  super(child:child);

   @override
 PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return Mypopupmenuitensatate();
  }

}

class Mypopupmenuitensatate<T,PopupMenuItem> extends PopupMenuItemState<T,Mypopupmenuitem<T>>
{
  @override
  void handleTap() {
    widget.onclick();
    super.handleTap();
  }

}