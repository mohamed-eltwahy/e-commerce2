import 'package:buy_it/Screens/login_screen.dart';
import 'package:buy_it/Screens/signup_screen.dart';
import 'package:buy_it/admin/add_product.dart';
import 'package:buy_it/admin/adminhome.dart';
import 'package:buy_it/admin/edit_product.dart';
import 'package:buy_it/admin/manage_products.dart';
import 'package:buy_it/home.dart';
import 'package:buy_it/provider/admin_mode.dart';
import 'package:buy_it/provider/modelhud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(create: (context) => ModalHud()),
        ChangeNotifierProvider<AdminMode>(create: (context)=>AdminMode()),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
      
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUp.id: (context) => SignUp(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id:(context)=>AdminHome(),
          AddProduct.id:(context)=>AddProduct(),
          Manageproducts.id:(context)=>Manageproducts(),
          EditProduct.id:(context)=>EditProduct(),
        },
      ),
    );
  }
}
