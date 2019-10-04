import 'package:flutter/material.dart';
import 'package:future_care/providers/product.dart';
import 'package:future_care/screens/category_products_screen.dart';
import 'package:provider/provider.dart';

class CategoryItemWidget extends StatelessWidget {
  final String title;
  final int id;
  final String image;

  CategoryItemWidget({this.id, this.title, this.image});

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CategoryProductScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
    Provider.of<Product>(context).loadData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        padding: EdgeInsets.only(top: 15, right: 10, left: 10),
        child: Material(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(image)),
                ),
                SizedBox(
                  height: 8,
                ),
                FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
