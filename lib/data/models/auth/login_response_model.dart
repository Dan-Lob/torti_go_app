// lib/data/models/auth/login_response_model.dart

import 'package:torti_go_app/domain/entities/auth/login_response.dart';

class LoginResponseModel {
  final String token;
  final int? expiresIn;

  LoginResponseModel({
    required this.token,
    this.expiresIn,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      expiresIn: json['expires_in'],
    );
  }

  LoginResponse toEntity() {
    return LoginResponse(token: token);
  }
}
