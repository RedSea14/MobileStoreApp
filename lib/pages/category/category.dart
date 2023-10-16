import 'package:appbanhang/pages/category/widget/category_body.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  static const routename = '/category';

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data['name']);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(data['name']),
          ),
        ),
        body: const CategodyBody());
  }
}
