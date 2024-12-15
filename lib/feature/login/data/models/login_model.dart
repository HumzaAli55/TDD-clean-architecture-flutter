// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:mock_api_practice/feature/login/domain/entities/login.dart';

class LoginModel extends LoginEntity {
 @override
  final int id;
 @override
  final String username;
 @override
  final String email;
 @override
  final String firstName;
 @override
  final String lastName;
 @override
  final String gender;
 @override
  final String image;
 @override
  final String token;
 @override
  final String refreshToken;

  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
    required this.refreshToken,
  }) : super(firstName: firstName, lastName: lastName, gender: gender, image: image, token: token, refreshToken: refreshToken, email: email, id: id, username: username);

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    image: json["image"],
    token: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "image": image,
    "accessToken": token,
    "refreshToken": refreshToken,
  };
}
