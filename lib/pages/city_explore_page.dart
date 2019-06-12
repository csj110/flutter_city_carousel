// import 'package:city_carousel/model/Detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:city_carousel/model/Detail.dart';

final imagesList = [
  "assets/images/newyork.jpg",
  "assets/images/capetown.jpg",
  "assets/images/switzerland.jpg",
];
final colorList = [
  Colors.redAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.amber.shade50,
];

class CityExplorePage extends StatefulWidget {
  @override
  _CityExplorePageState createState() => _CityExplorePageState();
}

class _CityExplorePageState extends State<CityExplorePage> {
  int currentPage = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: true,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(microseconds: 500),
            color: colorList[currentPage],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 450.0,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return itemBuilder(index);
                  },
                  controller: _pageController,
                  pageSnapping: true,
                  onPageChanged: _onPageChanged,
                  itemCount: 3,
                  physics: ClampingScrollPhysics(),
                ),
              ),
              _detailBuilder(currentPage),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailBuilder(index) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
          }
          return Expanded(
            child: Transform.translate(
              offset: Offset(0, 300 - value * 300),
              child: Opacity(
                opacity: (value - 0.7) * 3,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        detailsList[index].title,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        detailsList[index].description,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Container(
                          width: 80.0,
                          height: 5.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Read More',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget itemBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              height: Curves.easeIn.transform(value) * 450,
              child: child,
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              height:
                  Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                      450,
              child: child,
            ),
          );
        }
      },
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9.0),
                  bottomRight: Radius.circular(9.0)),
              child: Image.asset(
                imagesList[index],
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
