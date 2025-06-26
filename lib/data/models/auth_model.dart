import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';

class AuthModel {
  final int authId;
  final String email;
  final int userId;

  AuthModel({
    required this.authId,
    required this.email,
    required this.userId
  });
}