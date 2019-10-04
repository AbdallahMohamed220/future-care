import 'package:flutter/material.dart';
import 'package:future_care/screens/branches_screen.dart';
import 'package:future_care/screens/offers_screen.dart';
import 'package:future_care/screens/suggetion_screen.dart';
import 'package:future_care/screens/who_are_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = Provider.of<Auth>(context).userName;
    if (name == null) {
      name = "";
    }
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello $name'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(
              'Who we are',
            ),
            onTap: () {
              Navigator.of(context).pushNamed(WhoAreScreen.routeName);
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Offers'),
            onTap: () {
              Navigator.of(context).pushNamed(OffersScreen.routeName);
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text(
              'Branches',
            ),
            onTap: () {
              Navigator.of(context).pushNamed(BranshesScreen.routeName);
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text(
              'Complaints and suggestions',
            ),
            onTap: () {
              Navigator.of(context).pushNamed(SuggestionScreen.routeName);
            },
          ),
          Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
            ),
            onTap: () {
              Provider.of<Auth>(context).logout(context);
            },
          ),
          Divider(
            height: 2,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  color: Colors.blue[800],
                  icon: new Icon(MdiIcons.facebook),
                  onPressed: () {
                    print('Using the sword');
                  }),
              IconButton(
                  color: Colors.blue[200],
                  icon: new Icon(MdiIcons.twitter),
                  onPressed: () {
                    print('Using the sword');
                  }),
              IconButton(
                  color: Colors.red,
                  icon: new Icon(MdiIcons.instagram),
                  onPressed: () {
                    print('Using the sword');
                  }),
              IconButton(
                  color: Colors.teal,
                  icon: new Icon(MdiIcons.whatsapp),
                  onPressed: () {
                    print('Using the sword');
                  }),
              IconButton(
                  color: Colors.yellow,
                  icon: new Icon(MdiIcons.snapchat),
                  onPressed: () {
                    print('Using the sword');
                  })
            ],
          )
        ],
      ),
    );
  }
}
