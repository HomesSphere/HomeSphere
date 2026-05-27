import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyServer {
  static String url = dotenv.env['BASE_URL']!;
  static String domain = dotenv.env['BASE_DOMAIN']!;
  static String urlNoHttp = dotenv.env['BASE_URL_NOHTTP']!;
  static String streamServiceUrl = dotenv.env['STREAM_SERVICE_URL']!;
  static String publicVideo = dotenv.env['PUBLIC_VIDEO']!;
  static String videoUrl = dotenv.env['SECURE_VIDEO']!;
}

enum MyReguestType { post, get, put, del, file }

enum MyRequestApis {
  sendverificationcodesms,
  signupphone,
  userInterest,
  userInterestAdd,
  home,
  authenticate,
  register,
  userUpdate,
  userInfo,
  changePass,
  blog,
  blogDetail,
  note,
  noteDetail,
  engineer,
  engineerDetail,
  notenew,
  noteupdate,
  myads,
  ads,
  adsDetail,
  adsnew,
  forum,
  forumDetail,
  advice,
  adviceDetail,
  forgetpass,
  forgetVerification,
  validateEmail,
  passwordSendVerification,
  sendverificationcode,
  uploadFile,
  integrateFile,
  poll,
  pollDetail,
  pollAnswer,
  contact,
  logout,
  deleteuser,
  search,
  sendComment,
}

String getRequestUrlByType(MyRequestApis urlType) {
  var result = "";
  switch (urlType) {
    case MyRequestApis.sendverificationcodesms:
      result = "/auth/sendverificationcodesms";
      break;
    case MyRequestApis.signupphone:
      result = "/auth/signupphone";
      break;
    case MyRequestApis.authenticate:
      result = "/auth/login?type=jwt";
      break;
    case MyRequestApis.register:
      result = "/auth/signup";
      break;
    case MyRequestApis.userInterest:
      result = "/userinterest/source";
      break;
    case MyRequestApis.userInterestAdd:
      result = "/userinterest";
      break;

    case MyRequestApis.userUpdate:
      result = "/users?";
      break;
    case MyRequestApis.forgetpass:
      result = "/auth/passwordsendverification";
      break;
    case MyRequestApis.forgetVerification:
      result = "/auth/passwordrecover";
      break;
    case MyRequestApis.deleteuser:
      result = "/auth/delete";
      break;
    case MyRequestApis.changePass:
      result = "/users/changepassword?";
      break;
    case MyRequestApis.sendverificationcode:
      result = "/auth/sendverificationcode";
      break;
    case MyRequestApis.validateEmail:
      result = "/auth/validateEmail?";
      break;
    case MyRequestApis.userInfo:
      result = "/auth/current";
      break;
    case MyRequestApis.logout:
      result = "/auth/logout";
      break;
    case MyRequestApis.blog:
      result = "/blog?type=blog";
      break;
    case MyRequestApis.blogDetail:
      result = "/blog/";
      break;
    case MyRequestApis.engineer:
      result = "/blog?type=engineer";
      break;
    case MyRequestApis.engineerDetail:
      result = "/blog/";
      break;
    case MyRequestApis.ads:
      result = "/ads/published";
      break;
    case MyRequestApis.myads:
      result = "/ads/my";
      break;
    case MyRequestApis.adsDetail:
      result = "/ads/";
      break;
    case MyRequestApis.adsnew:
      result = "/ads";
      break;
    case MyRequestApis.note:
      result = "/note";
      break;
    case MyRequestApis.noteDetail:
      result = "/note/";
      break;
    case MyRequestApis.notenew:
      result = "/note";
      break;
    case MyRequestApis.noteupdate:
      result = "/note/";
      break;
    case MyRequestApis.uploadFile:
      result = "/file/upload";
      break;
    case MyRequestApis.integrateFile:
      result = "/file/post";
      break;
    case MyRequestApis.forum:
      result = "/blog?type=post";
      break;
    case MyRequestApis.forumDetail:
      result = "/blog/";
      break;
    case MyRequestApis.advice:
      result = "/blog?type=recom";
      break;
    case MyRequestApis.adviceDetail:
      result = "/blog/";
      break;
    case MyRequestApis.poll:
      result = "/poll/published";
      break;
    case MyRequestApis.pollDetail:
      result = "/poll/";
      break;
    case MyRequestApis.pollAnswer:
      result = "/poll/choiceanswer";
      break;
    case MyRequestApis.contact:
      result = "/contact";
      break;
    case MyRequestApis.home:
      result = "/home";
      break;
    case MyRequestApis.sendComment:
      result = "/comment";
      break;
    case MyRequestApis.search:
      result = "/search?";
      break;
    default:
  }

  return result;
}
