import 'package:flutter/material.dart';

class BranshesScreen extends StatelessWidget {
  static const routeName = 'BranshesScreen';
  const BranshesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branshes', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.23,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      fit: BoxFit.contain)),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent),
          Positioned(
              top: 220.0,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height - 100.0,
                  width: MediaQuery.of(context).size.width)),
          Positioned(
            top: 240,
            left: 25,
            child: Text(
              'Our Braches',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Positioned(
            top: 290,
            left: MediaQuery.of(context).size.width * 0.12,
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400], width: 1.5),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FittedBox(
                  child: Text(
                    'Jeddah-Khalidiya-Prince Sultan Street',
                    style: TextStyle(color: Colors.grey[900], fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 360,
            left: MediaQuery.of(context).size.width * 0.12,
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400], width: 1.5),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: 'Comming Soon ',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'In Bagdad',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
