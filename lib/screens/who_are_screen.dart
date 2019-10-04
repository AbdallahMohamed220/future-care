import 'package:flutter/material.dart';

class WhoAreScreen extends StatelessWidget {
  static const routeName = 'WhoAreScreen';
  const WhoAreScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who We Are', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Stack(
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
                height: MediaQuery.of(context).size.height + 930,
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
                    height: MediaQuery.of(context).size.height + 750,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
              top: 240,
              left: 25,
              child: Text(
                'Who We are',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Positioned(
              top: 250,
              left: 15,
              child: Container(
                height: 270,
                width: 330,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '- Future Care Group is at the forefront of home healthcare providers, as one of the first specialized companies in the sector in Saudi Arabia. Although we have not been the first, we have been and continue to be the most prevalent in the region, and we strive to expand our service areas.',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey[900], fontSize: 20),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 515,
              left: 25,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 330,
                child: Text(
                  '- The support of our patients and their trust in us led us to make them the focus of our attention so we communicated with them and our deep understanding of their suffering was our constant development of our services to suit their needs.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 710,
              left: 25,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 330,
                child: Text(
                  '- Future Care Group was established in the summer of 2016 as a limited liability company chaired by Dr. Fahd bin Abdulaziz bin Hasher and began to provide services on a small scale.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 860,
              left: 25,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 320,
                child: Text(
                  '- In early 2017, Future Care Group was contracted as a home medical care provider with insurance companies.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 960,
              left: 25,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 320,
                child: Text(
                  '- In 2018, Saudi Arabian Airlines, Petro Rabigh, Royal Court and Royal Guard were contracted to provide our services to their employees.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 1085,
              left: 25,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 320,
                child: Text(
                  '- In mid-2019 International SOS, Sans (Saudi Arabian Air Navigation Services) was contracted.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 1195,
              left: 25,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 500,
                width: 320,
                child: Text(
                  '-We at Future Care Group place great importance on the comfort and development of our team members in their careers and We are keen to implement a system of rewarding recognition of the achievements and allow specialists to express their passion, and provide them with a career that allows them to grow and achieve success in the areas of health care.',
                  style: TextStyle(color: Colors.grey[900], fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
