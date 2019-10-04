import 'package:flutter/material.dart';
import 'package:future_care/providers/auth.dart';
import 'package:future_care/providers/cart.dart';
import 'package:future_care/providers/product.dart';
import 'package:future_care/screens/auth_screen.dart';
import 'package:future_care/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItemWidget extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String image;

  ProductItemWidget({
    this.id,
    this.title,
    this.price,
    this.image,
  });

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      ProductDetialsScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context).findById(id);
    final cartItem = Provider.of<Cart>(context);

    Future<String> _showDialogError() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('To Confirm order You Should SignUp'),
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

    return InkWell(
        onTap: () => selectMeal(context),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              leading: Hero(
                tag: id,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
              ),
              title: Text(title ?? ''),
              subtitle: Text('$price' ?? ''),
              trailing: Consumer<Auth>(
                builder: (ctx, auth, _) => IconButton(
                  onPressed: () {
                    if (auth.isAuth) {
                      cartItem.addItem(product.id.toString(), product.title,
                          product.price, product.image);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item added to cart!'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              cartItem.removeSingleItem(product.id.toString());
                            },
                          ),
                          backgroundColor: Colors.black,
                        ),
                      );
                    } else {
                      _showDialogError();
                    }
                  },
                  icon: Icon(Icons.shopping_basket,
                      color: Colors.red, size: 30.0),
                ),
              ),
            ),
          ),
        ));
  }
}
