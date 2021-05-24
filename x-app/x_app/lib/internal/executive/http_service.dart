import 'package:x_app/models/index.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static http.Client _client = http.Client();
  static Map<String, String> headerSesion = {};

  postRequestWithHeader(url, body, headers) async {
    Map<String, String> headersSend = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie': headers["cookie"],
    };
    return _client
        .post(
      url,
      headers: headersSend,
      body: body,
    )
        .then((http.Response response) {
      return response;
    });
  }

  postRequest(url, body) async {
    return _client
        .post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "connection-mobil": "yes",
      },
      body: body,
    )
        .then((http.Response response) {
      return response;
    });
  }

  postRequestWithAuth(url, body) async {
    return _client
        .post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "connection-mobil": "yes",
        "cookie": HttpServices.headerSesion["cookie"],
      },
      body: body,
    )
        .then((http.Response response) {
      return response;
    });
  }

  getRequestWithAuth(url) async {
    return _client.get(
      url,
      headers: {
        "connection-mobil": "yes",
        "cookie": HttpServices.headerSesion["cookie"],
      },
    ).then((http.Response response) {
      return response;
    });
  }

  getRequest(url) async {
    return _client.get(url).then((http.Response response) {
      return response;
    });
  }
}
