import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import './cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String orderState;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime,
      this.orderState});
}

class Orders with ChangeNotifier {
  WooCommerceAPI wooCommerceAPI = new WooCommerceAPI(
      "https://fc.med.sa/",
      "ck_898d1ab30cc2e2da08091b096472f383cdebd8a1",
      "cs_9cc18fe4ad8748866357b7877bc9a5aa50ef322b");

  List<OrderItem> _orders = [];
  List<OrderItem> loadData = [];
  List<OrderItem> completedOrders = [];
  List<OrderItem> failedOrders = [];
  List<OrderItem> processingOrders = [];
  List<OrderItem> onHoledOrders = [];
  List<OrderItem> cancelledOrders = [];
  List<OrderItem> pendingOrders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetData(String careatoryemail) async {
    try {
      List<dynamic> extractedData = await wooCommerceAPI.getAsync(
        "orders",
      );

      if (extractedData.isEmpty) {
        return;
      }

      for (int i = 0; i < extractedData.length; i++) {
        if (extractedData[i]['line_items'].length == 2) {
          if (extractedData[i]['billing']['email'] == careatoryemail) {
            loadData.add(OrderItem(
              id: extractedData[i]['id'].toString(),
              amount: double.parse(extractedData[i]['shipping_total']),
              dateTime: DateTime.parse(extractedData[i]['date_created']),
              orderState: extractedData[i]['status'],
              products: (extractedData[i]['line_items'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                        id: item['id'].toString(),
                        title: item['name'],
                        price: double.parse(item['total']),
                        quantity: item['quantity']),
                  )
                  .toList(),
            ));
            ////////////////////////////////////////////
            if (extractedData[i]["status"] == 'completed') {
              completedOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            ////////////////////////////////////////////////////////////////
            if (extractedData[i]["status"] == 'failed') {
              failedOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            /////////////////////////////////////////////////////////////////////////////////

            if (extractedData[i]["status"] == 'pending') {
              pendingOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            //////////////////////////////////////////////////////////////////////////////
            if (extractedData[i]["status"] == 'processing') {
              processingOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            /////////////////////////////////////////////////////////////////////

            if (extractedData[i]["status"] == 'on-hold') {
              onHoledOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            ///////////////////////////////////////////////////////////////
            if (extractedData[i]["status"] == 'cancelled') {
              cancelledOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            //////////////////////////////////////////////////////////////

          }
        } else if (extractedData[i]['line_items'].length < 2) {
          if (extractedData[i]['billing']['email'] == careatoryemail) {
            loadData.add(OrderItem(
              id: extractedData[i]['id'].toString(),
              amount: double.parse(extractedData[i]['shipping_total']),
              orderState: extractedData[i]['status'],
              dateTime: DateTime.parse(extractedData[i]['date_created']),
              products: (extractedData[i]['line_items'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                        id: item['id'].toString(),
                        title: item['name'],
                        price: double.parse(item['total']),
                        quantity: item['quantity']),
                  )
                  .toList(),
            ));

            /////////////////////////////////////////////////////////////////////////////////

            if (extractedData[i]["status"] == 'completed') {
              completedOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            //////////////////////////////////////////////////////////////////////////////
            if (extractedData[i]["status"] == 'failed') {
              failedOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            /////////////////////////////////////////////////////////////////////

            if (extractedData[i]["status"] == 'pending') {
              pendingOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            ///////////////////////////////////////////////////////////////
            if (extractedData[i]["status"] == 'processing') {
              processingOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            //////////////////////////////////////////////////////////////
            if (extractedData[i]["status"] == 'on-hold') {
              onHoledOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
            //////////////////////////////////////////////////////////////

            if (extractedData[i]["status"] == 'cancelled') {
              cancelledOrders.add(OrderItem(
                id: extractedData[i]['id'].toString(),
                amount: double.parse(extractedData[i]['shipping_total']),
                dateTime: DateTime.parse(extractedData[i]['date_created']),
                orderState: extractedData[i]['status'],
                products: (extractedData[i]['line_items'] as List<dynamic>)
                    .map(
                      (item) => CartItem(
                          id: item['id'].toString(),
                          title: item['name'],
                          price: double.parse(item['total']),
                          quantity: item['quantity']),
                    )
                    .toList(),
              ));
            }
          }
        }
      }

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addOrder(
      {List<CartItem> cartProducts,
      double total,
      String email,
      String name,
      String address,
      String phone}) async {
    try {
      var url =
          'https://fc.med.sa/wp-json/wc/v2/orders?consumer_key=ck_898d1ab30cc2e2da08091b096472f383cdebd8a1&consumer_secret=cs_9cc18fe4ad8748866357b7877bc9a5aa50ef322b';
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "status": "pending",
            "billing": {
              "first_name": name,
              "last_name": "",
              "address_1": address,
              "address_2": "",
              "city": "",
              "state": "",
              "postcode": "",
              "country": "",
              "email": email,
              "phone": phone,
            },
            "shipping": {
              "first_name": name,
              "last_name": "",
              "address_1": address,
              "address_2": "",
              "city": "",
              "state": "",
              "postcode": "",
              "country": "",
            },
            "line_items": cartProducts
                .map((cp) => {
                      'product_id': cp.id,
                      'name': cp.title,
                      'quantity': cp.quantity.toString(),
                      'price': cp.price,
                      'total': (cp.price * cp.quantity).toString(),
                    })
                .toList(),
            "shipping_lines": [
              {
                "method_id": "flat_rate",
                "method_title": "Flat Rate",
                "total": total.toString(),
              }
            ]
          }));
      // var response = await wooCommerceAPI.postAsync("orders", {
      //   "payment_method": "bacs",
      //   "payment_method_title": "Direct Bank Transfer",
      //   "status": "pending",
      //   "set_paid": true,
      //   "billing": {
      //     "first_name": name,
      //     "last_name": "",
      //     "address_1": address,
      //     "address_2": "",
      //     "city": "",
      //     "state": "",
      //     "postcode": "",
      //     "country": "",
      //     "email": email,
      //     "phone": phone,
      //   },
      //   "shipping": {
      //     "first_name": name,
      //     "last_name": "",
      //     "address_1": address,
      //     "address_2": "",
      //     "city": "",
      //     "state": "",
      //     "postcode": "",
      //     "country": "",
      //   },
      //   "line_items": cartProducts
      //       .map((cp) => {
      //             'product_id': cp.id,
      //             'name': cp.title,
      //             'quantity': cp.quantity.toString(),
      //             'price': cp.price,
      //             'total': (cp.price * cp.quantity).toString(),
      //           })
      //       .toList(),
      //   "shipping_lines": [
      //     {
      //       "method_id": "flat_rate",
      //       "method_title": "Flat Rate",
      //       "total": total.toString(),
      //     }
      //   ]
      // });

      print(response.toString());
      print(response.statusCode);
      print('done');
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
