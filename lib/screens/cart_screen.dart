import 'package:flutter/material.dart';
import 'package:future_care/providers/auth.dart';
import 'package:future_care/providers/orders.dart';
import 'package:future_care/widgets/app_drawer.dart';
import 'package:future_care/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Card(
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total :',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartData.totalAmount.toStringAsFixed(2)}' ?? '',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  OrderButton(
                    cart: cartData,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                id: cartData.items.values.toList()[i].id,
                productId: cartData.items.keys.toList()[i],
                title: cartData.items.values.toList()[i].title,
                price: cartData.items.values.toList()[i].price,
                quantity: cartData.items.values.toList()[i].quantity,
                imgUrl: cartData.items.values.toList()[i].imgUrl,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  Future<void> showAlert(String phoneNumber) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('order Statue '),
        content: Text(
          'Your Order Is Send Please wait A call to $phoneNumber  to Confirm your order',
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okey'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context).userEmail;
    final userName = Provider.of<Auth>(context).userName;
    final address = Provider.of<Auth>(context).userAddress;
    final phoneNumber = Provider.of<Auth>(context).userPhoneNumber;
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
            )
          : Text(
              'Order Now!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              try {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    cartProducts: widget.cart.items.values.toList(),
                    total: widget.cart.totalAmount,
                    address: address,
                    email: email,
                    name: userName,
                    phone: phoneNumber);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
                showAlert(phoneNumber);
              } catch (error) {
                widget.cart.clear();
                setState(() {
                  _isLoading = false;
                });
                showAlert(phoneNumber);
              }
            },
    );
  }
}
