import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CategoryItem {
  final int id;
  final String title;
  final String image;

  CategoryItem({
    @required this.id,
    @required this.title,
    @required this.image,
  });
}

class Category with ChangeNotifier {
  List<dynamic> _categoryList = [];

  List<dynamic> get categoryList {
    return [..._categoryList];
  }

  List<dynamic> loadData = [];

  Future<void> fetchAndSetData() async {
    var url =
        'https://fc.med.sa/wp-json/wc/v2/products/categories?consumer_key=ck_898d1ab30cc2e2da08091b096472f383cdebd8a1&consumer_secret=cs_9cc18fe4ad8748866357b7877bc9a5aa50ef322b';

    try {
      final response = await http.get(url);
      List<dynamic> extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }

      for (int i = 0; i < extractedData.length; i++) {
        loadData.add(CategoryItem(
            id: extractedData[i]['id'],
            title: extractedData[i]['name'],
            image: extractedData[i]['image']['src']));
      }
      notifyListeners();
    } catch (error) {
      print(error);
      print(error);
      throw error;
    }
  }
}
