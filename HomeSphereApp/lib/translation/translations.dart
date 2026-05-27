import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_us.dart';
import 'mn_trans.dart';

class TranslationService extends Translations {
  static final locale = Get.deviceLocale;
  static const fallbackLocale = Locale('mn', 'MN');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'mn_MN': mnTrans,
      };
}
