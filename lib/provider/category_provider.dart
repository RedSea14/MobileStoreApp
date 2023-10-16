import 'dart:convert';

import 'package:appbanhang/model/category_model.dart';
import 'package:appbanhang/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  Future<List<CategoryModel>> getCategory() async {
    try {
      final response = await http.get(
          Uri.parse('http://apiforlearning.zendvn.com/api/mobile/categories'));
      final jsondata = jsonDecode(response.body);
      List<CategoryModel> listData = List<CategoryModel>.from(
          jsondata.map((data) => CategoryModel.fromJson(jsonEncode(data))));
      return listData;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }

  Future<List<ProductModel>> getProductCategory(id) async {
    try {
      final url =
          'http://apiforlearning.zendvn.com/api/mobile/categories/$id/products';

      Uri uri = Uri.parse(url);
      final finalUri = uri.replace(queryParameters: {});

      final response = await http.get(finalUri);
      final jsondata = jsonDecode(response.body);
      // print(jsondata)
      List<ProductModel> listData = List<ProductModel>.from(
          jsondata.map((data) => ProductModel.fromJson(jsonEncode(data))));
      return listData;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }
}
