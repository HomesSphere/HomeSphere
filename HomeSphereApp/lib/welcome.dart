import '/config/component_config.dart';
import '/config/constants.dart';
import 'config/icon_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helpers/main_helper.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Welcome> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = Get.size.width;
    double cHeight = Get.size.height;

    return Scaffold(
      body: Container(
        height: cHeight,
        width: cWidth,
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 40),
                child: IconButton(
                  icon: const Icon(
                    MyIconConfig.help,
                    size: 21.0,
                    color: MyColors.white,
                  ),
                  onPressed: () {
                    debugPrint("help clicked");
                  },
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                left: myContainerLeftPadding,
                right: myContainerRightPadding,
              ),
              children: <Widget>[
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            'welcome_title'.tr,
                            style: MyTextStyles.textStyle59,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'welcome_desc'.tr,
                          style: MyTextStyles.textStyle60,
                        ),
                      ),
                      const SizedBox(height: 72.0),
                      Container(
                        margin: const EdgeInsets.only(top: 21),
                        child: Text(
                          'welcome_login'.tr,
                          style: MyTextStyles.textStyle29,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: myContainerBottomPadding),
              child: FutureBuilder<String>(
                future: getVersionStr(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Text(
                            "VERSION ${snapshot.data.toString()}",
                            style: MyTextStyles.textStyle61,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
