import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/homepage_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/account_screen.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePageScreen(),
        'title': 'Home',
      },
      {
        'page': FavoritesScreen(),
        'title': 'Favorite',
      },
      {
        'page': CartScreen(),
        'title': 'Cart',
      },
      {'page': OrdersScreen(), 'title': 'Orders'},
      {
        'page': AccountScreen(),
        'title': 'Account',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: bmnav.BottomNav(
        elevation: 8,
        color: Colors.white,
        index: _selectedPageIndex,
        iconStyle: bmnav.IconStyle(
            color: Colors.grey,
            onSelectColor: Theme.of(context).primaryColor,
            size: 20,
            onSelectSize: 35),
        onTap: (index) {
          _selectPage(index);
        },
        items: [
          bmnav.BottomNavItem(Icons.home),
          bmnav.BottomNavItem(Icons.favorite),
          bmnav.BottomNavItem(Icons.shopping_cart),
          bmnav.BottomNavItem(Icons.today),
          bmnav.BottomNavItem(Icons.person)
        ],
      ),
    );
  }
}
