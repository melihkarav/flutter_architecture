import 'dart:convert';

import 'package:x_app/internal/executive/http_service.dart';
import 'package:x_app/internal/executive/session_executive.dart';
import 'package:x_app/internal/model/DTO/user_dto.dart';
import 'package:x_app/internal/statics/configs/general_config.dart';

class LoginService {
  HttpServices _httpService = HttpServices();

  Future<bool> auth(username, password) async {
    try {
      var responseGet =
          await _httpService.getRequest(GeneralConfig.serviceURL + "/login");
      var csrfToken =
          responseGet.body.split('name="_csrf_token" value="')[1].split('"')[0];
      responseGet.headers["cookie"] = responseGet.headers["set-cookie"];
      Map<String, Object> dataBody = {
        'username': username,
        'password': password,
        '_csrf_token': csrfToken,
      };
      responseGet.headers["set-cookie"] = "";
      var response = await _httpService.postRequestWithHeader(
          GeneralConfig.serviceURL + "/login", dataBody, responseGet.headers);
      HttpServices.headerSesion["cookie"] =
          response.headers["set-cookie"].toString().split(';')[0];
      if (response.body.split('Redirecting to <a href="/">/</a>.').length > 1) {
        var responseUserData = await _httpService
            .getRequestWithAuth(GeneralConfig.serviceURL + "/api/v1/getuser");
        UserDTO _userDto = UserDTO.fromJson(jsonDecode(responseUserData.body));
        Session.setUser(_userDto, password);

        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }
}
