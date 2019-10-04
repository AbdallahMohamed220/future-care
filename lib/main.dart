import 'package:flutter/material.dart';
import 'package:future_care/app_localization.dart';
import 'package:future_care/providers/auth.dart';
import 'package:future_care/providers/category.dart';
import 'package:future_care/providers/product.dart';
import 'package:future_care/screens/account_screen.dart';
import 'package:future_care/screens/auth_screen.dart';
import 'package:future_care/screens/branches_screen.dart';
import 'package:future_care/screens/category_products_screen.dart';
import 'package:future_care/screens/edit_account_screen.dart';
import 'package:future_care/screens/offers_screen.dart';
import 'package:future_care/screens/product_details_screen.dart';
import 'package:future_care/screens/suggetion_screen.dart';
import 'package:future_care/screens/tabs_screen.dart';
import 'package:future_care/screens/who_are_screen.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Product>.value(
          value: Product(),
        ),
        ChangeNotifierProvider<Category>.value(
          value: Category(),
        ),
        ChangeNotifierProvider<Auth>.value(
          value: Auth(),
        ),
        ChangeNotifierProvider<Cart>.value(
          value: Cart(),
        ),
        ChangeNotifierProvider<Orders>.value(
          value: Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: Color(0xffCCB029),
            primaryColor: Color(0xff046D73),
            cardColor: Colors.grey[700],
            canvasColor: Colors.white,
          ),

          supportedLocales: [
            Locale('ar', 'EG'),
            Locale('en', 'US'),
          ],
          // These delegates make sure that the localization data for the proper language is loaded
          localizationsDelegates: [
            // THIS CLASS WILL BE ADDED LATER
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },

          //home: auth.isAuth ? TabsScreen() : AuthScreen(),
          home: TabsScreen(),
          routes: {
            TabsScreen.routeName: (context) => TabsScreen(),
            CategoryProductScreen.routeName: (context) =>
                CategoryProductScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            ProductDetialsScreen.routeName: (context) => ProductDetialsScreen(),
            AccountScreen.routeName: (context) => AccountScreen(),
            EditeAccount.routeName: (context) => EditeAccount(),
            BranshesScreen.routeName: (context) => BranshesScreen(),
            WhoAreScreen.routeName: (context) => WhoAreScreen(),
            OffersScreen.routeName: (context) => OffersScreen(),
            SuggestionScreen.routeName: (context) => SuggestionScreen()
          },
        ),
      ),
    );
  }
}
