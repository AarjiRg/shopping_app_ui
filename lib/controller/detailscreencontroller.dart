
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_app_ui/model/productmodel.dart';

class Detailcreencontroller with ChangeNotifier {
  ProductModel? singleproduct;
  bool isloading = false;

  Future<void> fetchData( productid) async {
    var url = Uri.parse("https://fakestoreapi.com/products/$productid");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      isloading = true;
      notifyListeners();
      singleproduct = singleproductdetailsModelFromJson(response.body);
    }
    isloading = false;
    notifyListeners();
  }
}
