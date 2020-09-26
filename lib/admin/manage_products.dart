import 'package:buy_it/admin/edit_product.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:buy_it/utilities/popupmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';

class Manageproducts extends StatefulWidget {
  static String id = 'Manageproducts';

  @override
  _ManageproductsState createState() => _ManageproductsState();
}

class _ManageproductsState extends State<Manageproducts> {
  final store = Store();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadproducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(Product(
                pId: doc.documentID,
                pName: data[kproductname],
                pPrice: data[kproductprice],
                pCategory: data[kproductcategory],
                pDescription: data[kproductdescription],
                pLocation: data[kproductlocation],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTapUp: (details) async {
                  double dx = details.globalPosition.dx;
                  double dy = details.globalPosition.dy;
                  double dx2 = MediaQuery.of(context).size.width - dx;
                  double dy2 = MediaQuery.of(context).size.height - dy;
                  await showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [
                        Mypopupmenuitem(
                          onclick: () {
                            Navigator.pushNamed(context, EditProduct.id,arguments: products[index]);
                          },
                          child: Text('Edit'),
                        ),
                        Mypopupmenuitem(
                          onclick: () {
                            store.deleteProducts(products[index].pId);
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                      ]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          products[index].pLocation,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.6,
                        child: Container(
                          color: Colors.white,
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].pName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '\$ ${products[index].pPrice}',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
