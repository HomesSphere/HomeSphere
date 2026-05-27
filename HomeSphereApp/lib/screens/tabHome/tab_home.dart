import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/config/api_config.dart';
import '/helpers/api_helper.dart';
import '/helpers/component_helper.dart';
import '/config/constants.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<TabHome> {
  @override
  void initState() {
    super.initState();

    _downloadTopData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void btnSliderCallback(dynamic item) {
    if (kDebugMode) {
      print(item);
    }
    Get.toNamed('/teachers');
  }

  void calculatePercentage(int part, int total) {
    if (total == 0) {
      if (kDebugMode) {
        print("Total cannot be zero.");
      }
      return;
    }
    double percentage = (part / total) * 100;
    if (kDebugMode) {
      print("Percentage: ${percentage.toStringAsFixed(2)}%");
    }
  }

  void btnNewsCallback(dynamic item) {
    Get.toNamed('/newsDetail');
  }

  Future<void> _downloadTopData() async {
    debugPrint("dowloading..........");
    await requestAPI(
      MyReguestType.get,
      '0',
      null,
      MyRequestApis.home,
      false,
    ).then((value) {
      if (value != null) {
        if (value["retType"] == 0) {
          setState(() {});
        } else {
          getErrorNotif(value["retDesc"]);
        }
      } else {
        getErrorNotif('Та интернет холболтоо шалгана уу');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size cSize = MediaQuery.of(context).size;

    return Container(
      color: MyColors.dark,
      height: cSize.height,
      width: cSize.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 196, child: const SizedBox()),
            Container(height: 8, color: MyColors.dark),
            Container(
              color: MyColors.darkThree,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 21, right: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'home_lesson_title'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            color: MyColors.lightPeriwinkle,
                            fontWeight: FontWeight.w500,
                            fontFamily: MyFont.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/homeLessons');
                          },
                          child: Text(
                            'home_lesson_title_more'.tr,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              color: MyColors.grassyGreen,
                              fontSize: 13,
                              fontFamily: MyFont.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(),
                  Container(height: 8, color: MyColors.dark),
                ],
              ),
            ),
            Container(
              color: MyColors.darkThree,
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 21,
                      right: 21,
                      bottom: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'home_news_title'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            color: MyColors.lightPeriwinkle,
                            fontWeight: FontWeight.w500,
                            fontFamily: MyFont.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed('/news');
                          },
                          child: Text(
                            'home_news_title_more'.tr,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              color: MyColors.grassyGreen,
                              fontSize: 13,
                              fontFamily: MyFont.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            // homeNews(item['news'], context, cWidth),
          ],
        ),
      ),
    );
  }
}
