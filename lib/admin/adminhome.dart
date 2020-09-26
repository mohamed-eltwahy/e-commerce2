import 'package:buy_it/admin/add_product.dart';
import 'package:buy_it/admin/manage_products.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kmaincolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .6,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushNamed(context, AddProduct.id);
                    },
                    child: Text(
                      'Add Product',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .6,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pushNamed(context, Manageproducts.id);
                    },
                    child: Text(
                      'Edit Product',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .6,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text(
                      'View Orders',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
