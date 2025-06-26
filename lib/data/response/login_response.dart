import 'package:project_hibiki_point_mobile_app/data/models/auth_model.dart';

class LoginResponse extends AuthModel {
  final String generateToken;

  LoginResponse({
    required super.authId,
    required super.email,
    required super.userId,
    required this.generateToken
  });

  factory LoginResponse.postAuthLogin(Map<String, dynamic> object) {
    // Konversi semua field ke string untuk menghindari type error
    return LoginResponse(
        authId: object['id'] ?? 0,
        email: object['email'] ?? '',
        userId: object['user_id'] ?? 0, // Konversi ke string
        generateToken: object['token'] ?? object['generateToken'] ?? '' // Coba kedua nama field
    );
  }
}