import 'dart:math';
import 'package:flutter/material.dart';
import 'package:future_care/providers/cart.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

class OrderItem extends StatefulWidget {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String orderState;

  OrderItem(
      {this.id, this.amount, this.products, this.dateTime, this.orderState});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    Color color() {
      Color color = Colors.red;
      if (widget.orderState == 'processing') {
        color = Colors.grey;
        return color;
      } else if (widget.orderState == 'completed') {
        color = Colors.blue[300];
        return color;
      } else if (widget.orderState == 'on-hold') {
        color = Colors.lightGreenAccent[700];
        return color;
      } else if (widget.orderState == 'pending') {
        color = Colors.blue[900];
        return color;
      } else if (widget.orderState == 'cancelled') {
        color = Colors.red;
        return color;
      } else if (widget.orderState == 'failed') {
        color = Colors.orange;
        return color;
      } else if (widget.orderState == 'refunded') {
        color = Theme.of(context).primaryColor;
        return color;
      }
      return color;
    }

    return SafeArea(
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(widget.products.length * 20.0 + 110, 200)
                  : 85,
              child: SingleChildScrollView(
                child: Card(
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin:
                      EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Column(
                          children: widget.products
                              .map(
                                (prod) => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      FittedBox(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 13.0),
                                          child: Text(
                                            prod.title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy hh:mm')
                              .format(widget.dateTime),
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        trailing: IconButton(
                          color: Colors.black,
                          icon: Icon(_expanded
                              ? Icons.expand_less
                              : Icons.expand_more),
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                        ),
                      ),
                      if (_expanded)
                        AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 400),
                          padding:
                              EdgeInsets.symmetric(horizontal: 35, vertical: 4),
                          height: _expanded
                              ? min(widget.products.length * 20.0 + 10, 120)
                              : 0,
                          child: ListView(
                            children: widget.products
                                .map(
                                  (prod) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Text(
                                          prod.price.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${prod.quantity}x',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 1,
            left: 30,
            child: Badge(
              badgeColor: color(),
              shape: BadgeShape.square,
              borderRadius: 15,
              toAnimate: true,
              badgeContent: Text(widget.orderState,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
