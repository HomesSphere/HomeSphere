import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/config/constants.dart';
import '/config/icon_config.dart';
import '/screens/tabHome/tab_home.dart';
import '/screens/tabProfile/tab_profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Home> {
  int _selectedIndex = 0;

  set selectedIndex(int value) {
    _selectedIndex = value;
    // notifyListeners();
  }

  @override
  void initState() {
    super.initState();

    // _startInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  dynamic renderInner(dynamic context) {
    if (_selectedIndex == 0) {
      return const SizedBox(child: TabHome());
    } else if (_selectedIndex == 1) {
      return const SizedBox(child: TabHome());
    } else if (_selectedIndex == 2) {
      return const SizedBox(child: TabHome());
    } else if (_selectedIndex == 3) {
      return const SizedBox(child: TabProfile());
    }
  }

  dynamic renderTabBtn(int index, cWidth, icon) {
    var theStr = "home_tab$index";

    return Container(
      width: cWidth / 4,
      height: 80,
      color: MyColors.darkThree,
      // Flat button is depricated use TextButton instead
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectedIndex == index
                ? Icon(icon, color: MyColors.grassyGreen, size: 24)
                : Text(
                    theStr.tr,
                    style: const TextStyle(
                      color: MyColors.lightGreyBlue,
                      fontSize: 11,
                      fontFamily: MyFont.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;

    var rawTitle = "home_tab$_selectedIndex";

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Text(
              rawTitle.tr,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: MyColors.lightPeriwinkle,
                fontFamily: MyFont.normal,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/notif');
              },
              child: const Icon(MyIconConfig.notification, size: 21.0),
            ),
          ),
        ],
        backgroundColor: MyColors.darkThree,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: renderInner(context),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.lightBlue.shade600),
            bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          ),
          color: MyColors.darkTwo,
        ),
        height: 80,
        child: Row(
          children: <Widget>[
            renderTabBtn(0, cWidth, MyIconConfig.fullscreen),
            renderTabBtn(1, cWidth, MyIconConfig.search),
            renderTabBtn(2, cWidth, MyIconConfig.delguuruud),
            renderTabBtn(3, cWidth, MyIconConfig.miniiBulan),
          ],
        ),
      ),
    );
  }
}
