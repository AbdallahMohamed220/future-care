import 'package:flutter/material.dart';
import 'package:future_care/providers/auth.dart';
import 'package:future_care/providers/cart.dart';
import 'package:future_care/providers/product.dart';
import 'package:future_care/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/rating.dart';

class ProductDetialsScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    var loadproduct = Provider.of<Product>(context).loadData;
    var productId = ModalRoute.of(context).settings.arguments;
    final selectetProduct =
        loadproduct.firstWhere((product) => product.id == productId);
    final product = Provider.of<Product>(context, listen: false);
    final cartItem = Provider.of<Cart>(context, listen: false);

    Future<String> _showDialogError() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('To Confirm Order You Should SignUp'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('SingUp'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AuthScreen.routeName);
                    },
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            selectetProduct.title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (context) => ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height - 82.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent),
                  Positioned(
                      top: 240.0,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.0),
                                topRight: Radius.circular(45.0),
                              ),
                              color: Colors.white),
                          height: MediaQuery.of(context).size.height - 100.0,
                          width: MediaQuery.of(context).size.width)),
                  Positioned(
                      top: 30.0,
                      left: (MediaQuery.of(context).size.width / 2) - 100.0,
                      child: Hero(
                          tag: selectetProduct.id,
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(selectetProduct.image),
                                      fit: BoxFit.cover)),
                              height: 200.0,
                              width: 200.0))),
                  Positioned(
                    top: 215,
                    left: 20,
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Consumer<Product>(
                            builder: (ctx, product, _) => IconButton(
                              onPressed: () {
                                product.toggleFavoriteStauts(productId);
                              },
                              icon: Icon(
                                  product.isProductFavorite(productId)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: product.isProductFavorite(productId)
                                      ? Colors.red
                                      : Theme.of(context).canvasColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 260.0,
                      left: 25.0,
                      right: 25.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            child: Text(selectetProduct.title,
                                style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 20.0),
                          Text("SAR ${selectetProduct.price.toString()}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RatingWidget(),
                                RatingWidget(),
                                RatingWidget(),
                                RatingWidget(),
                                RatingWidget(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 70,
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              child: Consumer<Auth>(
                                  builder: (ctx, auth, _) => RaisedButton.icon(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: Theme.of(context).primaryColor,
                                        label: Text(
                                          'Add To Cart ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (auth.isAuth) {
                                            cartItem.addItem(
                                                product.id.toString(),
                                                product.title,
                                                product.price,
                                                product.image);
                                            Scaffold.of(context)
                                                .hideCurrentSnackBar();
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('Item added to cart!'),
                                                duration: Duration(seconds: 2),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {
                                                    cartItem.removeSingleItem(
                                                        product.id.toString());
                                                  },
                                                ),
                                                backgroundColor: Colors.black,
                                              ),
                                            );
                                          } else {
                                            _showDialogError();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.shopping_basket,
                                          color: Colors.white,
                                        ),
                                      )))
                        ],
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
