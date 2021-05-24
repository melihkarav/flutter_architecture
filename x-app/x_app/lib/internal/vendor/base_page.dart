import 'package:x_app/internal/book/helper_pages/not_permission_page.dart';
import 'package:x_app/internal/executive/session_executive.dart';
import 'package:x_app/internal/model/DTO/user_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasePage extends StatefulWidget {
  final State<StatefulWidget> stateConnective;
  final String authority;
  UserDTO sessionUser = Session.userInMermory;

  BasePage({@required this.stateConnective, this.authority}) : super() {
    print("BasePage Yapılandırıldı...");
  }

  @override
  State<StatefulWidget> createState() {
    if (authority != null) {
      if (Session.roles.contains(authority)) {
        return this.stateConnective;
      }
      return NotPermissionPageState();
    }
    return this.stateConnective;
  }
}
