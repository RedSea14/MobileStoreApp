import 'dart:convert';

import 'package:appbanhang/model/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SliderProvider extends ChangeNotifier {
  Future<List<Sli>> getSlider() async {
    try {
      final response = await http.get(
          Uri.parse('http://apiforlearning.zendvn.com/api/mobile/sliders'));
      final jsondata = jsonDecode(response.body);
      List<Sli> listData = List<Sli>.from(
          jsondata.map((data) => Sli.fromJson(jsonEncode(data))));
      return listData;
    } catch (e) {
      return Future.error(Exception('No Data'));
    }
  }
}
