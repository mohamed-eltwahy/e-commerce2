import 'package:buy_it/admin/edit_product.dart';
import 'package:buy_it/models/product.dart';
import 'package:buy_it/services/store.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:buy_it/utilities/popupmenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabbarindex = 0;
  final store = Store();
  int bottombarindex = 0;
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: bottombarindex,
                onTap: (value) {
                  setState(() {
                    bottombarindex = value;
                  });
                },
                fixedColor: kmaincolor,
                items: [
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                ]),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  indicatorColor: kmaincolor,
                  onTap: (value) {
                    setState(() {
                      tabbarindex = value;
                    });
                  },
                  tabs: [
                    Text(
                      'Jackets',
                      style: TextStyle(
                        color: tabbarindex == 0 ? Colors.black : Colors.grey,
                        fontSize: tabbarindex == 0 ? 16 : null,
                      ),
                    ),
                    Text(
                      'Trouser',
                      style: TextStyle(
                        color: tabbarindex == 1 ? Colors.black : Colors.grey,
                        fontSize: tabbarindex == 1 ? 16 : null,
                      ),
                    ),
                    Text(
                      'T-Shirts',
                      style: TextStyle(
                        color: tabbarindex == 2 ? Colors.black : Colors.grey,
                        fontSize: tabbarindex == 2 ? 16 : null,
                      ),
                    ),
                    Text(
                      'Shoes',
                      style: TextStyle(
                        color: tabbarindex == 3 ? Colors.black : Colors.grey,
                        fontSize: tabbarindex == 3 ? 16 : null,
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketpage(),
                Text('test'),
                Text('test'),
                Text('test'),
              ],
            ),
          ),
        ),
        Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget jacketpage() {
    return StreamBuilder<QuerySnapshot>(
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
    );
  }
}
