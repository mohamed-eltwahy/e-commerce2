import 'package:buy_it/models/product.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:buy_it/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imglocation;
  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
        
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Form(
              key: _globalKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _customtextfieldd('Product Name', (value) {
                      _name = value;
                    }),
                    _customtextfieldd('Product Price', (value) {
                      _price = value;
                    }),
                    _customtextfieldd('Product Description', (value) {
                      _description = value;
                    }),
                    _customtextfieldd('Product Category', (value) {
                      _category = value;
                    }),
                    _customtextfieldd('Product Location', (value) {
                      _imglocation = value;
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .6,
                        child: Builder(
                          builder: (context) => RaisedButton(
                            color: kmaincolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            onPressed: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Done'),
                              ));
                              if (_globalKey.currentState.validate()) {
                                _globalKey.currentState.save();
                                try {
                                  _store.addProduct(Product(
                                    pName: _name,
                                    pCategory: _category,
                                    pDescription: _description,
                                    pLocation: _imglocation,
                                    pPrice: _price,
                                  ));
                                } catch (e) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(e.message),
                                  ));
                                }
                              }
                            },
                            child: Text(
                              'Add Product',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customtextfieldd(String hint, Function onclick) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        cursorColor: kmaincolor,
        onSaved: onclick,
        decoration: InputDecoration(
          filled: true,
          fillColor: ktextfieldcolor,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
