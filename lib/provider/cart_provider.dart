import 'package:appbanhang/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Map<int, CartModel> items = {};

  void addCart(int productid, String image, String name, int price,
      [int quantity = 1]) {
    if (items.containsKey(productid)) {
      items.update(
          productid,
          (value) => CartModel(
                id: value.id,
                image: value.image,
                name: value.name,
                price: value.price,
                quantity: value.quantity + quantity,
              ));
    } else {
      items.putIfAbsent(
          productid,
          () => CartModel(
                id: productid,
                image: image,
                name: name,
                price: price,
                quantity: quantity,
              ));
    }
    notifyListeners();
  }

  void increase(int productid, [int quantity = 1]) {
    items.update(
        productid,
        (value) => CartModel(
            id: value.id,
            image: value.image,
            name: value.name,
            price: value.price,
            quantity: value.quantity + quantity));
    notifyListeners();
  }

  void decrease(int productid, [int quantity = 1]) {
    if (items[productid]?.quantity == quantity) {
      items.removeWhere((key, value) => key == productid);
    } else {
      items.update(
          productid,
          (value) => CartModel(
              id: value.id,
              image: value.image,
              name: value.name,
              price: value.price,
              quantity: value.quantity - quantity));
    }
    notifyListeners();
  }

  void removeItems() {
    items = {};
    notifyListeners();
  }
}
