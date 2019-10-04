import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_care/model/http_exception.dart';
import 'package:future_care/screens/auth_screen.dart';
import 'package:future_care/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String userName;
  String userNameEmail;
  String userEmail;
  String userPassword;
  String userAddress;
  String userPhoneNumber;
  String userId;
  bool isAuth = false;
  Auth(
      {this.userId,
      this.userName,
      this.userEmail,
      this.userAddress,
      this.userPhoneNumber,
      this.userPassword});
  var response;

  WooCommerceAPI wooCommerceAPI = new WooCommerceAPI(
      "https://fc.med.sa/",
      "ck_898d1ab30cc2e2da08091b096472f383cdebd8a1",
      "cs_9cc18fe4ad8748866357b7877bc9a5aa50ef322b");

  Future<void> signUp(String name, String email, String password,
      String address, String phoneNumber) async {
    try {
      response = await wooCommerceAPI.postAsync(
        "customers",
        {
          "email": email,
          "last_name": password,
          "first_name": name,
          "billing": {
            "first_name": name,
            "address_1": address,
            "phone": phoneNumber
          }
        },
      );
      if (response['message'] != null) {
        throw HttpException(response['code']);
      } else {
        throw HttpException('Sign Up Done');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      response = await wooCommerceAPI.getAsync(
        "customers",
      );
      for (int i = 0; i < response.length; i++) {
        if (response[i]['email'] == email) {
          if (response[i]['last_name'] == password) {
            userName = response[i]['first_name'];
            userNameEmail = response[i]['username'];

            userPassword = response[i]['last_name'];
            userEmail = response[i]['email'];
            userAddress = response[i]['billing']['address_1'];
            userPhoneNumber = response[i]['billing']['phone'];

            userId = response[i]['id'].toString();
            isAuth = true;
            final prefs = await SharedPreferences.getInstance();
            final userData = json.encode({
              'userId': userId,
              'userEmail': userName,
            });

            prefs.setString('userData', userData);

            notifyListeners();
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            return;
          }
        }
      }

      for (int i = 0; i < response.length; i++) {
        if (response[i]['email'] != email ||
            response[i]['last_name'] != password) {
          throw HttpException('SOMETHING_WENT_WRONG');
        }
      }
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    userId = extractData['userId'];
    userEmail = extractData['userEmail'];

    notifyListeners();
    return true;
  }

  Future<void> updateUser(String userId, String name, String email,
      String password, String address, String phone) async {
    final url =
        'https://fc.med.sa/wp-json/wc/v3/customers/$userId?consumer_key=ck_898d1ab30cc2e2da08091b096472f383cdebd8a1&consumer_secret=cs_9cc18fe4ad8748866357b7877bc9a5aa50ef322b';

    try {
      await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "first_name": name,
            "email": email,
            "last_name": password,
            "billing": {
              "first_name": name,
              "address_1": address,
              "phone": phone
            },
            "shipping": {"first_name": name}
          }));

      userName = name;
      userPassword = password;
      userEmail = email;
      userAddress = address;
      userPhoneNumber = phone;

      userId = userId;
      isAuth = true;
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'userId': userId,
        'userEmail': userName,
      });

      prefs.setString('userData', userData);

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void logout(BuildContext context) {
    Provider.of<Auth>(context).isAuth = false;
    Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
  }
}
