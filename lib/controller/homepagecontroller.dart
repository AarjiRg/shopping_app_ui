import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_app_ui/model/productmodel.dart';

class Homescreencontroller with ChangeNotifier{
  List categoryList=["All"];
  List<ProductModel>ProductList=[];
   bool isloading=false;
   bool isproductloading=false;
  int selectedindex=0;
 Future<void> getCategories()async{
  var url=Uri.parse("https://fakestoreapi.com/products/categories");
  var response= await http. get(url);
  if(response.statusCode==200){
    categoryList=["All"];
    isloading=true;
    notifyListeners();
    categoryList.addAll(jsonDecode(response.body));
  }
  isloading=false;
  notifyListeners();
  }
   oncategoryselection(int index){
    selectedindex=index;
    notifyListeners();
    if(selectedindex==0){
      getAllProducts();
    }
    else{
   String selectedCategory = categoryList[selectedindex]; 
    getproductsbycategories(selectedCategory);
    }

  }
  Future<void> getAllProducts()async{
    isproductloading=true;
    notifyListeners();
    final url=Uri.parse("https://fakestoreapi.com/products");
    try{
      var res=await http.get(url);
      ProductList=productModelFromJson(res.body);

    }catch(e){
print(e);
    }
    isproductloading=false;
    notifyListeners();

  }


   Future<void> getproductsbycategories(String category)async{
    isproductloading=true;
    notifyListeners();
    final url=Uri.parse("https://fakestoreapi.com/products/category/$category");
    try{
      var res=await http.get(url);
      ProductList=productModelFromJson(res.body);

    }catch(e){
print(e);
    }
    isproductloading=false;
    notifyListeners();

  }


}