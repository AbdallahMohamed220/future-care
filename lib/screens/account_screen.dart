import 'package:flutter/material.dart';
import 'package:future_care/providers/auth.dart';
import 'package:future_care/screens/auth_screen.dart';
import 'package:future_care/screens/edit_account_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = 'account';

  const AccountScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userName = Provider.of<Auth>(context).userName;

    if (userName == null) {
      userName = 'Admin';
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Account', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                child: Icon(Icons.edit),
                onTap: () {
                  Navigator.of(context).pushNamed(EditeAccount.routeName);
                },
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 4,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[300],
        drawer: AppDrawer(),
        body: Consumer<Auth>(builder: (ctx, auth, _) {
          if (auth.isAuth) {
            return ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(height: 260),
                    Positioned(
                        top: 30.0,
                        left: (MediaQuery.of(context).size.width / 2) - 80,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              userName.substring(0, 1),
                              style: TextStyle(
                                  fontSize: 60,
                                  color: Theme.of(context).canvasColor),
                            ),
                          ),
                        )),
                    Positioned(
                      top: 185,
                      left: 105,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          '${Provider.of<Auth>(context).userName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 215,
                      left: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          '@${Provider.of<Auth>(context).userNameEmail}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 170,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).primaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                    'Email : ${Provider.of<Auth>(context).userEmail}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              FittedBox(
                                child: Text(
                                    'Address : ${Provider.of<Auth>(context).userAddress}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              FittedBox(
                                child: Text(
                                    'Phone : ${Provider.of<Auth>(context).userPhoneNumber}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: Text('To Have Profile Page You Should SignUp'),
              actions: <Widget>[
                FlatButton(
                  child: Text('SignUp'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                ),
              ],
            );
          }
        }));
  }
}
