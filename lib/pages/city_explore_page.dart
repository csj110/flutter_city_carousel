import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:city_carousel/model/Detail.dart';

final imagesList=[
  "assets/images/newyork.jpg",
  "assets/images/capetown.jpg",
  "assets/images/switzerland.jpg",
];
final colorList=[
  Colors.redAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.amber.shade50,
];
class CityExplorePage extends StatefulWidget {
  @override
  _CityExplorePageState createState() => _CityExplorePageState();
}

class _CityExplorePageState extends State<CityExplorePage> {
  int currentPage=0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: true,
      viewportFraction: 0.8,
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
      body: Column(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context,index){
              return itemBuilder(index);
            },
            controller: _pageController,
            pageSnapping: true,
            onPageChanged: _onPageChanged,
            itemCount: 3,
            physics: ClampingScrollPhysics(),
          ),
          _detailBuilder(index),
        ],
      ),
    );
  }

  Widget _detailBuilder(index){
    return Column(children: <Widget>[
      
    ],);
  }

  Widget itemBuilder(index){
    return AnimatedBuilder(
        animation: _pageController,
        builder: (context,child){
          double value=1;
          if (_pageController.position.haveDimensions) {
            value=_pageController.page-index;
            value=(1-(value.abs()*0.5)).clamp(0.0,1.0);
            return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom:10.0),
              height: Curves.easeIn.transform(value)*300,
              child: child,
              ),
            );
          } else {
            return Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom:10.0),
              height: Curves.easeIn.transform(index == 0 ? value : value*0.5)*300,
              child: child,
              ),
            );
          }
          
        },
        child: Material(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft:Radius.circular(8.0),
              bottomRight: Radius.circular(8.0)
              )
            ),
          child: Padding(
            padding: const EdgeInsets.only(left:5.0,right: 5.0,bottom:5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
              bottomLeft:Radius.circular(9.0),
              bottomRight: Radius.circular(9.0)
              ),
              child: Image.asset(imagesList[index],fit: BoxFit.fitHeight,)
              ),
          ),
          ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      print(index);
      currentPage = index;
    });
  }
}

