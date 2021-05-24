import 'dart:convert';

import 'package:x_app/internal/model/basic_models/base_dto.dart';

class UserDTO implements BaseDTO {
  UserDTO(
      {this.userID,
      this.birthDate,
      this.email,
      this.genderId,
      this.name,
      this.password,
      this.phoneNumber,
      this.registrationToken,
      this.statusId,
      this.surname,
      this.username,
      this.userTypeId,
      this.tenantID});

  UserDTO.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        name = json['name'],
        surname = json['surname'],
        username = json['username'],
        password = json['password'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        userTypeId = json['userTypeId'],
        statusId = json['statusId'],
        registrationToken = json['registrationToken'],
        genderId = json['genderId'],
        tenantID = json['tenantID'],
        birthDate = json['birthDate'];

  Map<String, dynamic> toJson() => {
        'userID': this.userID,
        'name': this.name,
        'surname': this.surname,
        'username': this.username,
        'password': this.password,
        'phoneNumber': this.phoneNumber,
        'email': this.email,
        'userTypeId': this.userTypeId,
        'statusId': this.statusId,
        'registrationToken': this.registrationToken,
        'genderId': this.genderId,
        'tenantID': this.tenantID,
      };

  String toJsonString() => jsonEncode(this);

  int userID;
  String name;
  String surname;
  String username;
  String password;
  String phoneNumber;
  String email;
  int userTypeId;
  int statusId;
  String registrationToken;
  int genderId;
  String birthDate;
  String tenantID;
}
