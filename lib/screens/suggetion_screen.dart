import 'package:flutter/material.dart';

class SuggestionScreen extends StatelessWidget {
  static const routeName = 'SuggestionScreen';
  const SuggestionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestion', style: TextStyle(color: Colors.black)),
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
              'Suggestion',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Positioned(
            top: 290,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[500], width: 1.5),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FittedBox(
                  child: Text(
                    'Not available',
                    style: TextStyle(color: Colors.grey[400], fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
