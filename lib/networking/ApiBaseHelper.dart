import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:malikopal/model/BaseResponse_model.dart';
import 'package:malikopal/model/requestbody/ProfilePicReqBody_model.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/services/GlobalService.dart';

import 'AppException.dart';
import 'Endpoints.dart';

class ApiBaseHelper {
  //

  static final ApiBaseHelper _ApiBaseHelper = ApiBaseHelper._internal();

  factory ApiBaseHelper() {
    return _ApiBaseHelper;
  }

  ApiBaseHelper._internal();

  final String _baseUrl = Endpoints.site_url;

  Future<dynamic> getNew(String url) async {
    print('Get, url ${_baseUrl + url}');
    var responseJson;

    try {
      final response = await http
          .get(Uri.parse(_baseUrl + url), headers: getRequestHeader())
          .timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw FetchDataException(408, 'Request timeout');
        },
      );

      dp(msg: "Responce data", arg: response.body);

      return response.body;
    } on SocketException {
      print('No net');
      throw FetchDataException(0, 'No Internet connection');
    } catch (e) {
      dp(msg: "Error occur", arg: e);
    }

    print('Get received!');
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    print('Get, url ${_baseUrl + url}');
    final list = List<dynamic>;
    var responseJson;

    try {
      final response = await http
          .get(Uri.parse(_baseUrl + url), headers: getRequestHeader())
          .timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw FetchDataException(408, 'Request timeout');
        },
      );

      dp(msg: "Responce data", arg: response.body);

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException(0, 'No Internet connection');
    } catch (e) {
      dp(msg: "Error occur", arg: e);
    }

    print('Get received!');
    print(responseJson);
    return responseJson ?? list;
  }

  Future<dynamic> postNew(String url, dynamic requestBody) async {
    var body = json.encode(requestBody);

    print('Post, url $url, reqBody: ${body.toString()}');

    var heders = getRequestHeader();

    dp(msg: "Base url", arg: _baseUrl);
    dp(msg: " url", arg: url);
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: heders, body: body);

      dp(msg: "Responce status code", arg: response.body);

      return response.body;
    } on SocketException {
      print('No net');
      throw FetchDataException(0, 'No Internet connection');
    } catch (e) {
      print('unknow error');
      print(e);
      throw BadRequestException(200, e);
    }
  }

  Future<dynamic> post(String url, dynamic requestBody) async {
    //

    var body = json.encode(requestBody);

    var responseJson;

    print('Post, url $url, reqBody: ${body.toString()}');

    var heders = getRequestHeader();

    //

    dp(msg: "Base url", arg: _baseUrl);
    dp(msg: "Base url", arg: url);
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: heders, body: body);
      dp(msg: "Responce status code status", arg: response.statusCode);
      dp(msg: "Responce status code", arg: response.body);

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException(0, 'No Internet connection');
    } catch (e, s) {
      dp(msg: "Error in type", arg: s);
      dp(msg: "Error in post data", arg: e);
      throw e;
    }

    print('Post received!');
    return responseJson;
  }

  Future<dynamic> postProfilePic(String url, String filePath) async {
    final publicKey = '';
    final imageType = lookupMimeType(filePath).toString();
    final fileName = filePath.split('/').last;
    final base64Image = base64Encode(File(filePath).readAsBytesSync());
    ProfilePicReqDataModel req = ProfilePicReqDataModel(
        publicKey: publicKey,
        imageType: imageType,
        fileName: fileName,
        base64Image: base64Image);
    var body = json.encode(req);
    try {
      final response = await http.post(Uri.parse(url), body: body);
      switch (response.statusCode) {
        case 200:
        case 201:
          if (response.body.isNotEmpty) {
            return response.body.toString();
          }
          return '';
        case 302:
        case 400:
        case 401:
        case 403:
        case 404:
        case 500:
          throw BadRequestException(
              response.statusCode, parseErrorMessage(response.body.toString()));
        default:
          throw FetchDataException(response.statusCode,
              'Network error. StatusCode : ${response.statusCode}');
      }
    } on SocketException {
      print('No net');
      throw FetchDataException(0, 'No Internet connection');
    } catch (e) {
      print('unknow error');
      print(e);
      throw BadRequestException(200, e);
    }
  }

  Future<dynamic> multipart(String url, String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.fields['key'] = 'value';
    var responseJson;

    // detect mimetype of the file
    final mimeType = lookupMimeType(filePath);
    final mimeSplitted = mimeType?.split('/') ?? [];
    final mimePart1 = mimeSplitted.isNotEmpty ? mimeSplitted[0] : 'application';
    final mimePart2 = mimeSplitted.length > 1 ? mimeSplitted[1] : 'unknown';
    final fileName = filePath.split('/').last;

    request.fields["publicKey"] = '692f691e-74a9-4d08-abad-5a6cfddad390';
    request.fields["imageType"] = mimeType.toString();
    request.fields["fileName"] = fileName;
    request.fields["base64Image"] =
        base64Encode(File(filePath).readAsBytesSync());
    print(
        'Multipart Post, url $url, file: $filePath, mime: $mimePart1/$mimePart2');

    try {
      request.files.add(http.MultipartFile('file',
          File(filePath).readAsBytes().asStream(), File(filePath).lengthSync(),
          filename: fileName, contentType: MediaType(mimePart1, mimePart2)));
      var responseStream = await request.send();
      var response = await http.Response.fromStream(responseStream);
      responseJson = _returnResponse(response);
    } catch (e) {
      print(e.toString());
    }

    print('Multipart response received!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        if (response.body.isNotEmpty) {
          Map<String, dynamic> responseJson =
              jsonDecode(response.body.toString());
          log(responseJson.toString());
          List<dynamic> errors = responseJson["ErrorList"] != null
              ? responseJson["ErrorList"]
              : [];
          var errorMsg = parseErrorMessage(response.body.toString());
          if (errors.length > 0) {
            throw BadRequestException(response.statusCode, errorMsg);
          }

          if (errorMsg.isNotEmpty && errorMsg != response.body) {
            throw BadRequestException(response.statusCode, errorMsg);
          }

          return responseJson;
        }
        return '';
      case 302:
      case 400:
      case 401:

      case 403:
      case 404:
      case 500:
        throw BadRequestException(
            response.statusCode, parseErrorMessage(response.body));
      default:
        throw FetchDataException(response.statusCode,
            'Network error. StatusCode : ${response.statusCode}');
    }
  }

  Map<String, String> getRequestHeader() {
    //

    var map = {
      'Content-Type': 'application/json',
      'User-Agent': 'nopstationcart.flutter/v1'
    };

    if (GlobalService().getAuthToken().isNotEmpty)
      map['Authorization'] = 'Bearer ' + GlobalService().getAuthToken();

    print('header: ${map.toString()}');

    return map;
  }

  String parseErrorMessage(String response) {
    var error = "";
    try {
      error = BaseResponseModel.fromJson(jsonDecode(response)).message ?? '';
    } catch (e) {
      error = jsonDecode(response)['Message'];
    }

    return error;
  }
}
