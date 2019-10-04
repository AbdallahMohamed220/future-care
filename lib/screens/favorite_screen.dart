import 'package:flutter/material.dart';
import 'package:future_care/widgets/app_drawer.dart';
import '../widgets/favorite_item.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class FavoritesScreen extends StatefulWidget {
  static const routName = 'favorite_screen';

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var favoriteList = Provider.of<Product>(context).favoriteItems;
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Favorite', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: favoriteList.isEmpty
            ? Center(
                child: Text("Not Favorite Item Star add some!"),
              )
            : ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
                    value: favoriteList[i], child: FavoriteItem())));
  }
}
