import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_app_ui/model/cartmodel.dart';
import 'package:shopping_app_ui/model/productmodel.dart';

class Cartscreencontroller with ChangeNotifier {
  bool isloading = false;
  ProductModel? singleproduct;
  List<Cartmodel> cartItems = [];
  List Keys = [];
   double totalcartprice = 0.0;

  final cartbox = Hive.box<Cartmodel>("cartbox");
  void getCartItems() {
    
    cartItems = cartbox.values.toList();
    totalcartvalue();
    notifyListeners();
  }

  Future<void> getproduct(String productId) async {
    var url = Uri.parse("https://fakestoreapi.com/products/$productId");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        isloading = true;
        notifyListeners();
        singleproduct = singleproductdetailsModelFromJson(response.body);
      }
      // if (singleproduct != null) {
      //     addproducts(
      //       id: singleproduct!.id!.toInt(),
      //       title: singleproduct!.title.toString(),
      //       price: singleproduct!.price!.toInt(),
      //       image: singleproduct!.image,
      //       description: singleproduct!.description,
      //     );
      //   }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  void addproducts(
      {
        required int id,
      required String title,
      required int price,
      String? image,
      String? description}
      ) {
         bool productExists = false;
         for(int i=0;i<cartItems.length;i++){
          if(cartItems[i].id==id){
            productExists=true;
          }
         }
         if(productExists){
         print("product already exists");
    return;
         }
    Cartmodel cartItem = Cartmodel(
      id: id,
      title: title,
      price: price.toDouble(),
      image: image,
      des: description,
      quantity: 1,
    );
    
    cartbox.add(cartItem);
    notifyListeners();
  }

  void removeproducts(int index) {
    cartbox.deleteAt(index);
    getCartItems();
    notifyListeners();
  }

      void incrementproduct(int index) {
    if (index >= 0 && index < cartItems.length) {
      Cartmodel cartItem = cartItems[index];
      cartItem.quantity = (cartItem.quantity ?? 1) + 1;
      cartbox.putAt(index, cartItem); 
      getCartItems(); 
    }
  }

  void decrementproduct(int index) {
    if (index >= 0 && index < cartItems.length) {
      Cartmodel cartItem = cartItems[index];
      if ((cartItem.quantity ?? 1) > 1) {
        cartItem.quantity = (cartItem.quantity ?? 1) - 1;
        cartbox.putAt(index, cartItem); 
      } 
      getCartItems();
    }
  }


  void totalcartvalue() {
    totalcartprice = 0;
   for(int i = 0; i < cartItems.length; i++) {
    totalcartprice += (cartItems[i].price! * cartItems[i].quantity!);
   }
print(totalcartprice);
  }
}
