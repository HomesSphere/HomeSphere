import 'dart:convert';
import 'dart:io';
import '/config/api_config.dart';
import 'main_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Map? responseResultParse(dynamic res) {
  debugPrint("res.statusCode==${res.statusCode}");
  debugPrint("res.body${res.body}--- ${res.body.toString().length}");

  if (res.body.isEmpty) {
    if (kDebugMode) {
      print("null bainaa body");
    }
  }
  if (res.statusCode == 200) {
    return {
      "retType": 0,
      "retData": res.body.isEmpty ? null : jsonDecode(res.body),
      "retDesc": "",
    };
  } else if (res.statusCode == 401) {
    return {
      "retType": 2,
      "retData": res.body.isEmpty ? null : jsonDecode(res.body),
      "retDesc": res.body.isEmpty ? "" : jsonDecode(res.body),
    };
  } else if (res.statusCode == 400) {
    return {
      "retType": 3,
      "retData": res.body.isEmpty ? null : jsonDecode(res.body),
      "retDesc": "",
    };
  } else {
    return {"retType": 1, "retData": null, "retDesc": jsonDecode(res.body)};
  }
}

Map responseErrorParse(dynamic res) {
  debugPrint(res.message);
  return {"retType": -1, "retData": null, "retDesc": res.message};
}

Future<Map?> requestAPI(
  MyReguestType reqType,
  String? headerParam,
  dynamic bodyParams,
  MyRequestApis urlType,
  bool requireAuth,
) async {
  String myURL = getRequestUrlByType(urlType);
  String? accessToken;
  if (await checkConnection() != true) {
    debugPrint('internet is down');
    return null;
  }

  Map<String, String> rawHeader = {};
  rawHeader["Content-Type"] = "application/json";
  // rawHeader["Cookie"] =
  //     'connect.sid=s%3AeC4xMXRSnLWet1Mg2SI1L.zeVWFXzb1XNPCyJtXKO5pZVx2n9R%2F1FBGDfNQDUXMk0';

  try {
    if (requireAuth) {
      accessToken = await getToken();
      debugPrint("Access token - $accessToken");

      if (accessToken != null) {
        rawHeader["Authorization"] = "Bearer $accessToken";
      }
    }

    Uri uri;

    if (headerParam != null) {
      var reqURL = MyServer.url + myURL + headerParam;
      uri = Uri.parse(reqURL);
    } else {
      uri = Uri.parse(MyServer.url + myURL);
    }

    debugPrint("uri--$uri");
    debugPrint("header - $rawHeader");
    debugPrint("body--${jsonEncode(bodyParams)}");

    if (MyReguestType.get == reqType) {
      try {
        final response = await http.get(uri, headers: rawHeader).catchError((
          err,
        ) {
          throw Exception('error');
        });
        return responseResultParse(response);
      } catch (err) {
        responseErrorParse(err);
      }
    } else if (MyReguestType.post == reqType) {
      try {
        final response = await http
            .post(
              uri,
              headers: rawHeader,
              body: utf8.encode(json.encode(bodyParams)),
            )
            .catchError((err) {
              throw Exception('error');
            });
        return responseResultParse(response);
      } catch (err) {
        responseErrorParse(err);
      }
    } else if (MyReguestType.put == reqType) {
      final response = await http
          .put(
            uri,
            headers: rawHeader,
            body: jsonEncode(bodyParams),
            encoding: Encoding.getByName("utf-8"),
          )
          .catchError((err) {
            debugPrint("aldaa");
            debugPrint(err);
            throw Exception('error');
          });

      return responseResultParse(response);
    } else if (MyReguestType.del == reqType) {
      final response = await http
          .delete(
            uri,
            headers: rawHeader,
            encoding: Encoding.getByName("utf-8"),
          )
          .catchError((err) {
            debugPrint("aldaa");
            debugPrint(err);
            throw Exception('error');
          });

      return responseResultParse(response);
    } else if (MyReguestType.file == reqType) {
      rawHeader["Content-Type"] = "multipart/form-data";

      try {
        final response = await http
            .post(
              uri,
              headers: rawHeader,
              body: utf8.encode(json.encode(bodyParams)),
            )
            .catchError((err) {
              throw Exception('error');
            });
        return responseResultParse(response);
      } catch (err) {
        responseErrorParse(err);
      }
    }
  } catch (err) {
    return responseErrorParse(err);
  }

  return null;
}

Future<String?> getSignedRequestApiParams(XFile file) async {
  var reqURL =
      "${MyServer.url}${getRequestUrlByType(MyRequestApis.uploadFile)}?fileName=${file.name}&fileType=${getFileType(file.name)}";
  var uri = Uri.parse(reqURL);

  final response = await http.get(uri).catchError((err) {
    throw Exception('error');
  });

  return responseResultParse(response)?["retData"]?["signedRequest"];
}

Future<String?> uploadFileToS3(XFile file) async {
  String? signedReqResponse = await getSignedRequestApiParams(file);

  // Future<String> uploadToSignedUrl({required XFile file, required String signedUrl}) async {
  //     Uri uri = Uri.parse(signedUrl);
  //     var response = await put(uri, body: await file.readAsBytes(), headers: {"Content-Type": "image/jpg"});

  //     return response;

  //   }

  //  .put(uri,
  //               headers: rawHeader,
  //               body: jsonEncode(bodyParams),
  //               encoding: Encoding.getByName("utf-8"))

  if (kDebugMode) {
    print("signed Request");
    print(signedReqResponse);
  }

  if (signedReqResponse != null) {
    Uri uri = Uri.parse(signedReqResponse);

    final response = await http
        .put(
          uri,
          body: await file.readAsBytes(),
          headers: {"Content-Type": getFileType(file.name)},
        )
        .catchError((err) {
          throw Exception('error');
        });

    if (response.statusCode == 200) {
      return signedReqResponse.substring(
        0,
        signedReqResponse.indexOf("?Content-Type"),
      );
    } else {
      return null;
    }
  }
  return null;

  // final mimeType = lookupMimeType(file.path); // 'image/jpeg'
  // final contentType =
  //     MediaType(mimeType!.split('/')[0], mimeType.split('/')[1]);
  // debugPrint("contentType = $contentType");
  // request.files.add(await http.MultipartFile.fromPath('file', file.path,
  //     filename: fileName, contentType: contentType));
  // http.StreamedResponse response = await request.send();
  // debugPrint("response=$response");
  // if (response.statusCode == 200) {
  //   return {
  //     "retType": 0,
  //     "retData": await response.stream.bytesToString(),
  //     "retDesc": ""
  //   };
  // } else {
  //   return {"retType": 1, "retData": null, "retDesc": response.reasonPhrase};
  // }

  //    await axios
  //   .put(signedRequest, file, {
  //     headers: {
  //       "Content-Type": file.type,
  //     },
  //     cancelToken: cancel?.token,
  //     onUploadProgress: (progressEvent) => {
  //       let percentCompleted = Math.round(
  //         (progressEvent.loaded * 100) / progressEvent.total
  //       );
  //       setProgress && setProgress(percentCompleted);
  //     },
  //   })
  //   .then((data: any) => {
  //      console.log(data,signedRequest,url)
  //   })

  //   .catch(function (error) {
  //     if (axios.isCancel(error)) {
  //       console.log("Request canceled", error.message);
  //       returnUrl = "";
  //     } else {
  //       console.log("error:", error.message);
  //       console.log(error);
  //     }
  //   });

  // return returnUrl;
}

Future<bool> checkConnection() async {
  try {
    final result = await InternetAddress.lookup("www.google.com");
    if (kDebugMode) {
      print("result====$result");
    }

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    debugPrint('not connected');
    return false;
  }
}
