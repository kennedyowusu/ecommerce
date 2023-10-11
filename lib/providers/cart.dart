import 'package:ecommerce/modal/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cartList = [];

  List<Product> get cartList => _cartList;

  void toggleAddToCart(Product product) {
    if (_cartList.contains(product)) {
      for (Product item in _cartList) {
        item.quantity++;
      }
    } else {
      _cartList.add(product);
    }
    notifyListeners();
  }

  void toggleRemoveFromCart(Product product) {
    if (_cartList.contains(product)) {
      _cartList.remove(product);
    } else {
      for (Product item in _cartList) {
        item.quantity--;
      }
    }
    notifyListeners();
  }

  bool isAddedToCart(Product product) {
    return _cartList.contains(product);
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }

  void updateCart() {
    notifyListeners();
  }

  calcTotalPrice() {
    double total = 0.0;
    for (Product item in _cartList) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
