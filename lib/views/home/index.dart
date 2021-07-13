import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasa_app/controllers/Slider.dart';


class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int ntf = 1;
  int _currentSLider = 0;
  int _currentPromo = 0;
  final PageController _sliderControlller = PageController(initialPage: 0);
  final PageController _promoControlller = PageController(initialPage: 0);

  int bottomNavBarIndex;
  PageController _halamanController;
  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = 0;
    _halamanController = PageController(initialPage: bottomNavBarIndex);
    _getData();
    ntf = 1;
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentSLider < dataList.length) {
        _currentSLider++;
      } else {
        _currentSLider = 0;
      }

      _sliderControlller.animateToPage(_currentSLider,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPromo < dataList.length) {
        _currentPromo++;
      } else {
        _currentPromo = 0;
      }

      _promoControlller.animateToPage(_currentPromo,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _sliderControlller.dispose();
    _promoControlller.dispose();
    super.dispose();
  }

  _onPageChanges(int index) {
    setState(() {
      _currentSLider = index;
    });
  }

  _onPromoChanges(int indexPromo) {
    setState(() {
      _currentPromo = indexPromo;
    });
  }

  List dataList = new List();
  _getData() async {
    var data = SliderController().getData();
    await data.then((value) {
      setState(() {
        dataList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
            title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            // margin: EdgeInsets.only(top: 13.0),
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: "Cari apa di Jasa",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.blueGrey, fontSize: 13),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.blueGrey,
                    )),
              ),
            ),
          ),
        )),
        actions: [
          IconButton(
              icon: Stack(children: <Widget>[
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                Positioned(
                  // draw a red marble
                  top: 0.0,
                  right: 0.0,
                  child: Visibility(
                    visible: ntf == 0 ? false : true,
                    child: new Icon(Icons.brightness_1,
                        size: 12.0,
                        color: ntf != 0 ? Colors.red : Colors.transparent),
                  ),
                )
              ]),
              onPressed: () {
                _getData();
              },
              color: Colors.white),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 8.0),
          child: Text(
            "JASA",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF00b14f),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 18.0),
        child: BottomNavyBar(
          showElevation: true,
          itemCornerRadius: 24,
          selectedIndex: bottomNavBarIndex,
          items: [
             BottomNavyBarItem(
                icon: Icon(Icons.pages),
                title: Text('Home',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                activeColor: Color(0xFF00b14f),
                inactiveColor: Color(0xFF70747F),
                textAlign: TextAlign.start),
             BottomNavyBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Marketplace',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                activeColor: Color(0xFF00b14f),
                inactiveColor: Color(0xFF70747F),
                textAlign: TextAlign.start),
             BottomNavyBarItem(
                icon: Icon(Icons.departure_board),
                title: Text('Orders',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                activeColor: Color(0xFF00b14f),
                inactiveColor: Color(0xFF70747F),
                textAlign: TextAlign.start),
             BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Account',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                activeColor: Color(0xFF00b14f),
                inactiveColor: Color(0xFF70747F),
                textAlign: TextAlign.start),
          ],
          onItemSelected: (index) => setState(() {
            bottomNavBarIndex = index;
            _halamanController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF00b14f), Color(0x0000b14f)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: dataList == null || dataList == [] || dataList.isEmpty
                  ? Center(
                      child: SpinKitCircle(
                        color: Colors.yellow,
                      ),
                    )
                  : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _sliderControlller,
                      itemCount: dataList.length,
                      onPageChanged: _onPageChanges,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width * 0.80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(dataList[index].url),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18.0, bottom: 5, top: 10),
              child: Text("Layanan",
                  style: GoogleFonts.poppins(
                      color: Color(0xFF3b3b53), fontWeight: FontWeight.w500)),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(children: [
                      Image.asset(
                        "assets/transport.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Angkutan",
                        style: GoogleFonts.poppins(fontSize: 13),
                      )
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(children: [
                      Image.asset(
                        "assets/kurir.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Pengiriman",
                        style: GoogleFonts.poppins(fontSize: 13),
                      )
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(children: [
                      Image.asset(
                        "assets/makanan.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Makanan",
                        style: GoogleFonts.poppins(fontSize: 13),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(children: [
                      Image.asset(
                        "assets/kesehatan.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Kesehatan",
                        style: GoogleFonts.poppins(fontSize: 13),
                      )
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(children: [
                      Image.asset(
                        "assets/reparasi.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Tukang",
                        style: GoogleFonts.poppins(fontSize: 13),
                      )
                    ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(children: [
                      Image.asset(
                        "assets/lainnya.png",
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        "Lainnya",
                        style: GoogleFonts.poppins(fontSize: 13),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(left: 18.0, bottom: 5, top: 8),
              child: Text("Spesial Promo",
                  style: GoogleFonts.poppins(
                      color: Color(0xFF3b3b53), fontWeight: FontWeight.w500)),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: dataList == null || dataList == [] || dataList.isEmpty
                  ? Center(
                      child: SpinKitCircle(
                        color: Colors.yellow,
                      ),
                    )
                  : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _promoControlller,
                      itemCount: dataList.length,
                      onPageChanged: _onPromoChanges,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width * 0.80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(dataList[index].url),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18.0, bottom: 5, top: 8),
              child: Text("Artikel",
                  style: GoogleFonts.poppins(
                      color: Color(0xFF3b3b53), fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
