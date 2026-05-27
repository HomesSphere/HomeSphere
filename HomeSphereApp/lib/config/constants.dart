// STATIC KEYS
import 'dart:ui';

enum MyButtonType { normal, outlined, transparent, disabled }

enum MyInputType { email, phone, password, text, passwordAgain }

final class MyToken {
  static const String token = "token";
  static const String userInfo = "userInfo";
}

final class MyRegEx {
  static RegExp myRegexPhone = RegExp(r'[0-9]');
  static const int myPhoneLength = 8;
  static RegExp myRegexEmail = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  static RegExp myRegexPass = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
}

final class MyImage {
  static const String logo = 'assets/images/logo@3x.png';
  static const String chinggis = 'assets/images/chingisKhan.png';
}
// IMAGE KEYS

final List alphahabetList = [
  'А',
  'Б',
  'В',
  'Г',
  'Д',
  'Е',
  'Ё',
  'Ж',
  'З',
  'И',
  'Й',
  'К',
  'Л',
  'М',
  'Н',
  'О',
  'Ө',
  'Р',
  'С',
  'Т',
  'У',
  'Ү',
  'Ф',
  'Х',
  'Ц',
  'Ч',
  'Ш',
  'Щ',
  'Ъ',
  'Ь',
  'Э',
  'Ю',
  'Я',
];

final class MyFont {
  static const String normal = 'SFProDisplay';
  static const String myFontNormal = 'SFProDisplay';
  static const String myFontItalic = 'SFProDisplayItalic';
  static const String myFontRegular = 'SFProdisplayRegular';
  static const String myFontMedium = 'SFProDisplay-Medium';
  static const String myFontItalicBold = 'SFProDisplay-SemiboldItalic';
  static const String myFontSemiBold = 'SFProDisplay-Semibold';
  static const String myFontbold = 'SFProDisplay-Bold';
  static const String myFontChBold = 'CharterITCStd-Bold';
  static const String myFontLightItalic = 'SFProDisplay-LightItalic';
}

// COLORS
final class MyColors {
  static const dark = Color(0xff0f1217);
  static const lightGreyBlue = Color(0xffaab0bc);
  static const white = Color(0xffffffff);
  static const grassyGreen = Color(0xff37a000);
  static const dark65 = Color(0xa61b1e26);
  static const lightPeriwinkle = Color(0xffd7dce3);
  static const darkTwo = Color(0xff262a33);
  static const charcoalGrey = Color(0xff32363f);
  static const dark60 = Color(0x990f1217);
  static const brownishGrey = Color(0xff707070);
  static const darkThree = Color(0xff1b1e26);
  static const dark25 = Color(0x3f0f1217);
  static const orange = Color(0xfff2651d);
  static const ceruleanBlue = Color(0xff066fde);
  static const lightishBlue = Color(0xff4075f9);
  static const watermelon = Color(0xfffc4351);
  static const coolGrey = Color(0xffaab0bc);
}
