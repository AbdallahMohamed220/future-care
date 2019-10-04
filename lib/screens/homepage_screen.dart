import 'package:flutter/material.dart';
import 'package:future_care/providers/category.dart';
import 'package:provider/provider.dart';
import '../widgets/category_item.dart';
import '../widgets/app_drawer.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = 'Home_page';
  const HomePageScreen({Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var _loadedInitData = true;
  var _isloading = true;

  Future<void> _getData() async {
    Provider.of<Category>(context).loadData.clear();
    await Provider.of<Category>(context).fetchAndSetData();
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

  int counter = 0;
  void changeText() {
    if (counter == 0) {
      setState(() {
        counter = 1;
      });
    } else {
      setState(() {
        counter = 0;
      });
    }
  }

  List itemsTexts = [
    "Your pharmacy up to your door",
    "Exclusive !! Patient delivery service is now available"
  ];
  @override
  Widget build(BuildContext context) {
    var categoryList = Provider.of<Category>(context).loadData;

    return Scaffold(
        appBar: AppBar(
          title: Text('Future Care', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
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
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                              child: Carousel(
                            images: [
                              ExactAssetImage(
                                "assets/images/pic1.jpg",
                              ),
                              ExactAssetImage("assets/images/pic2.jpg")
                            ],
                            dotSize: 4.0,
                            dotSpacing: 15.0,
                            dotColor: Colors.white,
                            autoplay: true,
                            indicatorBgPadding: 5.0,
                            borderRadius: true,
                            onImageChange: (_, __) {
                              changeText();
                            },
                          )),
                        ),
                        Positioned(
                          right: 25,
                          top: 40,
                          left: 95,
                          child: Text(
                            itemsTexts[counter],
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 500,
                      width: 300,
                      child: GridView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: categoryList.length,
                          itemBuilder: (context, i) => CategoryItemWidget(
                                id: categoryList[i].id,
                                image: categoryList[i].image,
                                title: categoryList[i].title,
                              ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          )),
                    )
                  ],
                ),
              ));
  }
}
