import 'package:buy_it/models/product.dart';
import 'package:buy_it/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) {
    _firestore.collection(kproductscollections).add({
      kproductname: product.pName,
      kproductprice: product.pPrice,
      kproductdescription: product.pDescription,
      kproductcategory: product.pCategory,
      kproductlocation: product.pLocation,
    });
  }

  Stream<QuerySnapshot> loadproducts()  {

  
      return  _firestore.collection(kproductscollections).snapshots();
  
  }

  deleteProducts(documentid)
  {
    _firestore.collection(kproductscollections).document(documentid).delete();
  }

  editProducts(data,documentId)
  {
    _firestore.collection(kproductscollections).document(documentId).updateData(data);
  }
}
