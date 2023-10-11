import 'package:ecommerce/modal/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favoriteList = [];

  List<Product> get favoriteList => _favoriteList;

  void toggleFavorite(Product product) {
    if (_favoriteList.contains(product)) {
      _favoriteList.remove(product);
    } else {
      _favoriteList.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteList.contains(product);
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }

  void updateFavorite() {
    notifyListeners();
  }
}
