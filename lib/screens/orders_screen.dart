import 'package:flutter/material.dart';
import 'package:future_care/providers/auth.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as order;
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  var _loadedInitData = true;
  var _isloading = true;
  var _isLoadingComplete = false;
  var _isLoadingFailed = false;
  var _isLoadingPending = false;
  var _isLoadingProcessing = false;
  var _isLoadingOnhold = false;
  var _isLoadingCancelled = false;
  var _isLoadingAllData = false;

  dynamic ordersList;
  Future<void> _getData() async {
    Provider.of<Orders>(context).loadData.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).loadData;
  }

  Future<void> _getAlldOrders() async {
    setState(() {
      _isLoadingAllData = true;
    });
    Provider.of<Orders>(context).loadData.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).loadData;
    setState(() {
      _isLoadingAllData = false;
    });
  }

  Future<void> _cancelledOrders() async {
    setState(() {
      _isLoadingCancelled = true;
    });
    Provider.of<Orders>(context).cancelledOrders.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).cancelledOrders;
    setState(() {
      _isLoadingCancelled = false;
    });
  }

  Future<void> _completedOrders() async {
    setState(() {
      _isLoadingComplete = true;
    });

    Provider.of<Orders>(context).completedOrders.clear();

    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).completedOrders;

    setState(() {
      _isLoadingComplete = false;
    });
  }

  Future<void> _failedOrders() async {
    setState(() {
      _isLoadingFailed = true;
    });
    Provider.of<Orders>(context).failedOrders.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).failedOrders;
    setState(() {
      _isLoadingFailed = false;
    });
  }

  Future<void> _pendingOrders() async {
    setState(() {
      _isLoadingPending = true;
    });
    Provider.of<Orders>(context).pendingOrders.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).pendingOrders;

    setState(() {
      _isLoadingPending = false;
    });
  }

  Future<void> _onHoledOrders() async {
    setState(() {
      _isLoadingOnhold = true;
    });
    Provider.of<Orders>(context).onHoledOrders.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).onHoledOrders;
    setState(() {
      _isLoadingOnhold = false;
    });
  }

  Future<void> _processingOrders() async {
    setState(() {
      _isLoadingProcessing = true;
    });
    Provider.of<Orders>(context).processingOrders.clear();
    await Provider.of<Orders>(context)
        .fetchAndSetData(Provider.of<Auth>(context).userEmail);
    ordersList = Provider.of<Orders>(context).processingOrders;
    setState(() {
      _isLoadingProcessing = false;
    });
  }

  @override
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _isloading = true;
      });

      _getData().then((_) {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[300],
        drawer: AppDrawer(),
        body: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          FlatButton(
                            child: _isLoadingAllData
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('All'),
                            onPressed: () {
                              _getAlldOrders();
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            child: _isLoadingComplete
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('Completed'),
                            onPressed: () {
                              _completedOrders();
                            },
                            color: Colors.blue[300],
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            child: _isLoadingPending
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('Pending'),
                            onPressed: () {
                              _pendingOrders();
                            },
                            color: Colors.blue[900],
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            child: _isLoadingProcessing
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('Processing'),
                            onPressed: () {
                              _processingOrders();
                            },
                            color: Colors.grey,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            child: _isLoadingCancelled
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('Cancelled'),
                            onPressed: () {
                              _cancelledOrders();
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            child: _isLoadingFailed
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('Faild'),
                            onPressed: () {
                              _failedOrders();
                            },
                            color: Colors.orange,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FlatButton(
                            child: _isLoadingOnhold
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 5))
                                : Text('On Hold'),
                            onPressed: () {
                              _onHoledOrders();
                            },
                            color: Colors.lightGreenAccent[700],
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ordersList.length,
                      itemBuilder: (ctx, i) => order.OrderItem(
                        id: ordersList[i].id,
                        amount: ordersList[i].amount,
                        dateTime: ordersList[i].dateTime,
                        products: ordersList[i].products,
                        orderState: ordersList[i].orderState,
                      ),
                    ),
                  )
                ],
              ));
  }
}

/*

// Container(
          //   height: 400,
          //   width: 400,
          //   child: ListView.builder(
          //     itemCount: ordersList.length,
          //     itemBuilder: (ctx, i) => order.OrderItem(
          //       id: ordersList[i].id,
          //       amount: ordersList[i].amount,
          //       dateTime: ordersList[i].dateTime,
          //       products: ordersList[i].products,
          //       orderState: ordersList[i].orderState,
          //     ),
          //   ),
          // ),
          //   ],
          // )

*/
