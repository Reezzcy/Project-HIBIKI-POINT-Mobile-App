import 'package:project_hibiki_point_mobile_app/data/models/auth_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';

class RegisterResponse extends AuthModel {
  final UserModel user;

  RegisterResponse({
    required super.authId,
    required super.email,
    required super.userId,
    required this.user
  });

  factory RegisterResponse.postAuthRegister(Map<String, dynamic> object) {
    return RegisterResponse(
        user: object['new_user'],
        authId: object['id'].toString(),
        email: object['email'],
        userId: object['user_id']
    );
  }
}