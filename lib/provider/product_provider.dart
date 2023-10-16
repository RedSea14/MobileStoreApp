import 'dart:convert';

import 'package:appbanhang/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productSpecial = [];
  Future<List<ProductModel>> getProductSpecial() async {
    try {
      final response = await http.get(Uri.parse(
          'http://apiforlearning.zendvn.com/api/mobile/products?offset=0&sortBy=id&order=asc&special=true'));
      final jsondata = jsonDecode(response.body);
      List<ProductModel> listData = List<ProductModel>.from(
          jsondata.map((data) => ProductModel.fromJson(jsonEncode(data))));
      productSpecial = listData;
      return listData;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }

  Future<ProductModel> getProductById(id) async {
    try {
      final url = 'http://apiforlearning.zendvn.com/api/mobile/products/$id';

      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final jsondata = jsonDecode(response.body);
      // print(jsondata)
      ProductModel product = ProductModel.fromJson(jsonEncode(jsondata));
      return product;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }
}
