import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class Product with ChangeNotifier {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  bool isfavoirte;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.image,
      this.isfavoirte = false});

  WooCommerceAPI wooCommerceAPI = new WooCommerceAPI(
      "https://fc.med.sa/",
      "ck_898d1ab30cc2e2da08091b096472f383cdebd8a1",
      "cs_9cc18fe4ad8748866357b7877bc9a5aa50ef322b");

  List<Product> favoriteItems = [];

  List<Product> loadData = [];

  Future<void> fetchAndSetData(int categoryId) async {
    try {
      List<dynamic> extractedData = await wooCommerceAPI.getAsync(
        "products",
      );

      if (extractedData == null) {
        return;
      }

      for (int i = 0; i < extractedData.length; i++) {
        if (extractedData[i]['categories'].length == 2) {
          if (extractedData[i]['categories'][0]['id'] == categoryId ||
              extractedData[i]['categories'][1]['id'] == categoryId) {
            loadData.add(Product(
                id: extractedData[i]['id'],
                title: extractedData[i]['name'],
                price: double.parse(extractedData[i]['price']),
                image: extractedData[i]['images'][0]['src']));
          }
        } else if (extractedData[i]['categories'].length < 2) {
          if (extractedData[i]['categories'][0]['id'] == categoryId) {
            loadData.add(Product(
                id: extractedData[i]['id'],
                title: extractedData[i]['name'],
                price: double.parse(extractedData[i]['price']),
                image: extractedData[i]['images'][0]['src']));
          }
        }
      }

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> toggleFavoriteStauts(int id) async {
    final exsistingIndex =
        favoriteItems.indexWhere((product) => product.id == id);

    if (exsistingIndex >= 0) {
      favoriteItems.removeAt(exsistingIndex);
    } else {
      favoriteItems.add(loadData.firstWhere((product) => product.id == id));
    }

    notifyListeners();
  }

  bool isProductFavorite(int id) {
    return favoriteItems.any((product) => product.id == id);
  }

  Product findById(int id) {
    return loadData.firstWhere((prod) => prod.id == id);
  }
}
