import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'config/component_config.dart';
import 'helpers/main_helper.dart';
import '/config/constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Splash> {
  String versionStr = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadData() async {
    dynamic rawToken = await getToken();

    debugPrint("token");
    debugPrint(rawToken);

    if (rawToken != null && rawToken.toString().length > 10) {
      Get.offAndToNamed('/home');
    } else {
      Get.offAndToNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: cHeight,
        // width: cWidth,
        // color: Colors.red,
        decoration: const BoxDecoration(color: MyColors.dark),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              height: 70,
              // color: Colors.red,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MyImage.logo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: FutureBuilder<String>(
                future: getVersionStr(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          loadData();
                        });

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
