import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final String imgUrl;
  final double price;
  final int quantity;

  const CartItemWidget({
    this.id,
    this.productId,
    this.imgUrl,
    this.quantity,
    this.price,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeSingleItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are You Sure?'),
                  content: Text('Do you want to remove this item?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('okey'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ));
      },
      key: Key(UniqueKey().toString()),
      background: Container(
        color: Theme.of(context).cardColor,
        child: Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            leading: Container(
                child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imgUrl),
            )),
            title: Text(title),
            subtitle: Text('Total Price: \$${price * quantity}'),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
