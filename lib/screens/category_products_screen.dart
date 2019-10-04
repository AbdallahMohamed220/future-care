import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_item.dart';
import '../providers/product.dart';

class CategoryProductScreen extends StatefulWidget {
  static const routeName = '/category-products';

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  String categoryTitle;
  var _loadedInitData = true;
  var categoryId;
  var _isloading = true;

  Future<void> _getData(categoryId) async {
    await Provider.of<Product>(context).fetchAndSetData(categoryId);
  }

  @override
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _isloading = true;
      });
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      categoryTitle = routeArgs['title'];
      categoryId = routeArgs['id'];

      _getData(categoryId).then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var productsitems = Provider.of<Product>(context).loadData;
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (ctx, i) => ProductItemWidget(
                  id: productsitems[i].id,
                  image: productsitems[i].image,
                  title: productsitems[i].title,
                  price: productsitems[i].price,
                ),
                itemCount: productsitems.length,
              ));
  }
}
